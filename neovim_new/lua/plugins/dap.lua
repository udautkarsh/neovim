-- ============================================
-- Debugging (DAP) - VSCode-like debug workflow
-- ============================================

local function debug_python_file()
  local file = vim.fn.input("Python file: ", vim.fn.getcwd() .. "/", "file")
  if file == "" then
    return
  end

  file = vim.fn.fnamemodify(file, ":p")
  if vim.fn.filereadable(file) ~= 1 then
    vim.notify("File not readable: " .. file, vim.log.levels.ERROR)
    return
  end

  require("dap").run({
    type = "python",
    request = "launch",
    name = "Launch selected file",
    program = file,
    pythonPath = function()
      return require("utils").get_python_path(vim.uv.cwd())
    end,
  })
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
      "mfussenegger/nvim-dap-python",
      "folke/which-key.nvim",
    },
    -- ----------------------------------------------------------------
    -- Keymaps (pdb-style, all under <leader>D = "Debug")
    --   c = continue   n = next/step-over   s = step-into
    --   r = return/step-out   b = breakpoint   q = quit/terminate
    --   p = print/evaluate expression
    -- ----------------------------------------------------------------
    keys = {
      -- Stepping & control
      { "<leader>Dc", function() require("dap").continue() end,                desc = "Debug: Continue / Start (c)" },
      { "<leader>Dn", function() require("dap").step_over() end,               desc = "Debug: Step Over / Next (n)" },
      { "<leader>Ds", function() require("dap").step_into() end,               desc = "Debug: Step Into (s)" },
      { "<leader>Dr", function() require("dap").step_out() end,                desc = "Debug: Step Out / Return (r)" },
      { "<leader>Dq", function() require("dap").terminate() end,               desc = "Debug: Terminate (q)" },
      { "<leader>Dl", function() require("dap").run_last() end,                desc = "Debug: Run Last" },
      { "<leader>DC", function() require("dap").run_to_cursor() end,           desc = "Debug: Run to Cursor" },
      { "<leader>DL", function() require("dap").continue({ new = true }) end,  desc = "Debug: Pick Launch Config" },
      { "<leader>DF", debug_python_file,                                       desc = "Debug: Select Python File" },

      -- Breakpoints
      { "<leader>Db", function() require("dap").toggle_breakpoint() end,       desc = "Debug: Toggle Breakpoint (b)" },
      { "<leader>DB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Conditional Breakpoint" },

      -- Inspect & UI
      { "<leader>Dp", function() require("dap.ui.widgets").hover() end, mode = { "n", "v" }, desc = "Debug: Print / Evaluate (p)" },
      { "<leader>Du", function() require("dapui").toggle() end,                desc = "Debug: Toggle UI" },
      { "<leader>DR", function() require("dap").repl.toggle() end,             desc = "Debug: Toggle REPL" },

      -- Python test helpers (nvim-dap-python)
      { "<leader>Dt", function() require("dap-python").test_method() end,      desc = "Debug: Test Method (Python)" },
      { "<leader>DT", function() require("dap-python").test_class() end,       desc = "Debug: Test Class (Python)" },

      -- ------------------------------------------------------------------
      -- Fast shortcuts (no leader)
      --   <A-d>    toggle breakpoint
      --   <A-S-D>  toggle DAP UI  (Alt+Shift+D; Alt+d-d would block <A-d>
      --            by timeoutlen — bad UX)
      -- ------------------------------------------------------------------
      { "<A-d>",   function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint (Alt+d)" },
      { "<A-S-d>", function() require("dapui").toggle() end,          desc = "Debug: Toggle UI (Alt+Shift+D)" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup()
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = { "python" },
      })

      -- ------------------------------------------------------------------
      -- Resolve the Python that will run BOTH the DAP adapter and the
      -- program being debugged (they must be the same process — there is
      -- no way to split them with `launch` requests).
      --
      -- Strategy:
      --   1. Resolve the project's Python via utils.get_python_path
      --      (honours $VIRTUAL_ENV, local .venv, poetry, pipenv, …).
      --   2. If that Python is inside a venv but debugpy is missing,
      --      install debugpy into the venv automatically (uv > pip).
      --   3. If the resolved Python is the SYSTEM python (no venv) and
      --      debugpy is missing, switch the adapter to Mason's isolated
      --      debugpy install instead of polluting the system Python.
      -- ------------------------------------------------------------------
      local function venv_root_for(python_path)
        local root = python_path
          :gsub("[/\\]bin[/\\]python[0-9.]*$", "")
          :gsub("[/\\]Scripts[/\\]python%.exe$", "")
        if vim.fn.filereadable(root .. "/pyvenv.cfg") == 1 then
          return root
        end
        return nil
      end

      local function has_debugpy(python_path)
        local out = vim.fn.system({ python_path, "-c", "import debugpy" })
        return vim.v.shell_error == 0, out
      end

      local function install_into_venv(python_path, on_done)
        local cmd
        if vim.fn.executable("uv") == 1 then
          cmd = { "uv", "pip", "install", "--python", python_path, "debugpy" }
        else
          cmd = { python_path, "-m", "pip", "install", "debugpy" }
        end

        vim.notify(
          ("Installing debugpy into venv (%s)…"):format(table.concat(cmd, " ")),
          vim.log.levels.INFO,
          { title = "nvim-dap-python" }
        )

        vim.system(cmd, { text = true }, function(res)
          vim.schedule(function()
            if res.code == 0 then
              vim.notify("debugpy installed.", vim.log.levels.INFO, { title = "nvim-dap-python" })
              on_done(true)
            else
              vim.notify(
                "Failed to install debugpy:\n" .. (res.stderr or res.stdout or "unknown error"),
                vim.log.levels.ERROR,
                { title = "nvim-dap-python", timeout = false }
              )
              on_done(false)
            end
          end)
        end)
      end

      local function mason_debugpy_python()
        local p = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
        if vim.fn.executable(p) == 1 then return p end
        return nil
      end

      local project_python = require("utils").get_python_path(vim.uv.cwd())
      local adapter_python = project_python

      -- Activate DAP with whichever interpreter we have right now; if we
      -- need to switch to Mason debugpy below, re-call setup() then.
      require("dap-python").setup(adapter_python)

      vim.schedule(function()
        local ok = has_debugpy(adapter_python)
        if ok then return end

        local venv = venv_root_for(adapter_python)
        if venv then
          -- Inside a project venv → install debugpy there.
          install_into_venv(adapter_python, function(success)
            if not success then
              -- Fall back to Mason debugpy if available.
              local mason = mason_debugpy_python()
              if mason then
                require("dap-python").setup(mason)
                vim.notify(
                  "Falling back to Mason debugpy: " .. mason,
                  vim.log.levels.WARN,
                  { title = "nvim-dap-python" }
                )
              end
            end
          end)
        else
          -- System Python (no venv) → don't install globally; use Mason.
          local mason = mason_debugpy_python()
          if mason then
            require("dap-python").setup(mason)
            vim.notify(
              ("No venv detected; using Mason debugpy adapter:\n%s"):format(mason),
              vim.log.levels.INFO,
              { title = "nvim-dap-python" }
            )
          else
            vim.notify(
              "debugpy is missing and no Mason debugpy available.\nRun :MasonInstall debugpy",
              vim.log.levels.ERROR,
              { title = "nvim-dap-python", timeout = false }
            )
          end
        end
      end)

      -- ------------------------------------------------------------------
      -- DAP UI lifecycle
      --
      -- We open the UI on `event_initialized` (session ready), but we do
      -- NOT auto-close it on terminate/exit. Otherwise an error in the
      -- adapter or program would flicker the windows and you'd never see
      -- the message. Close it manually with <Space>Du or <A-S-d>.
      -- ------------------------------------------------------------------
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      -- ------------------------------------------------------------------
      -- Persist DAP errors
      --
      -- Capture stdout/stderr from the adapter and the debugged program
      -- into the notifier history. nvim-dap uses vim.notify; with Snacks
      -- notifier you can review past errors with <Space>un (history).
      -- We also keep the most recent error in a buffer-backed log so it
      -- can be re-opened with :DapErrors.
      -- ------------------------------------------------------------------
      local dap_errors = {}

      dap.listeners.after.event_output["dap_error_capture"] = function(_, body)
        if body and body.category == "stderr" and body.output and body.output ~= "" then
          table.insert(dap_errors, body.output)
          vim.notify(body.output, vim.log.levels.ERROR, { title = "DAP stderr" })
        end
      end

      -- If the adapter exits non-zero, surface it loudly and keep the
      -- message in history. The UI stays open so you can read scrollback.
      dap.listeners.after.event_exited["dap_error_summary"] = function(_, body)
        if body and body.exitCode and body.exitCode ~= 0 then
          local msg = ("DAP session exited with code %d. Run :DapShowLog or :DapErrors for details.")
            :format(body.exitCode)
          table.insert(dap_errors, msg)
          vim.notify(msg, vim.log.levels.ERROR, { title = "DAP", timeout = false })
        end
      end

      -- Command to re-open the most recent errors in a scratch buffer.
      vim.api.nvim_create_user_command("DapErrors", function()
        if #dap_errors == 0 then
          vim.notify("No DAP errors captured this session.", vim.log.levels.INFO)
          return
        end
        vim.cmd("botright new")
        vim.bo.buftype = "nofile"
        vim.bo.bufhidden = "wipe"
        vim.bo.swapfile = false
        vim.api.nvim_buf_set_name(0, "DAP Errors")
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(table.concat(dap_errors, "\n"), "\n"))
      end, { desc = "Show captured DAP errors" })

      -- which-key labels for the Debug group
      pcall(function()
        require("which-key").add({
          { "<leader>D", group = "debug", icon = "🐞" },
          { "<leader>Dc", desc = "Continue / Start" },
          { "<leader>Dn", desc = "Step Over (next)" },
          { "<leader>Ds", desc = "Step Into" },
          { "<leader>Dr", desc = "Step Out (return)" },
          { "<leader>Dq", desc = "Terminate" },
          { "<leader>Db", desc = "Toggle Breakpoint" },
          { "<leader>DB", desc = "Conditional Breakpoint" },
          { "<leader>Dp", desc = "Print / Evaluate" },
          { "<leader>DC", desc = "Run to Cursor" },
          { "<leader>Dl", desc = "Run Last Config" },
          { "<leader>DL", desc = "Pick Launch Config" },
          { "<leader>DF", desc = "Select Python File" },
          { "<leader>Du", desc = "Toggle Debug UI" },
          { "<leader>DR", desc = "Toggle REPL" },
          { "<leader>Dt", desc = "Debug Test Method" },
          { "<leader>DT", desc = "Debug Test Class" },
        })
      end)
    end,
  },
}
