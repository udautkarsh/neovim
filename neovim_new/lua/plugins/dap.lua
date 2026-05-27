-- ============================================
-- Debugging (DAP) — minimal defaults
-- ============================================
--
-- Plugin: nvim-dap (https://github.com/mfussenegger/nvim-dap)
-- Python: nvim-dap-python (https://github.com/mfussenegger/nvim-dap-python)
-- UI:     nvim-dap-ui (https://github.com/rcarriga/nvim-dap-ui)
--
-- This config uses plugin defaults wherever possible. No font / zoom /
-- resize logic. Use your terminal's normal Ctrl+- / Ctrl+= to change
-- font size manually if needed.

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

      -- Fast shortcuts (no leader)
      { "<A-d>",   function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint (Alt+d)" },
      { "<A-S-d>", function() require("dapui").toggle() end,          desc = "Debug: Toggle UI (Alt+Shift+D)" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Defaults for nvim-dap-ui and nvim-dap-virtual-text.
      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = { "python" },
      })

      -- ------------------------------------------------------------------
      -- nvim-dap-python: resolve the project Python interpreter and make
      -- sure debugpy is available in it. The adapter and the debugged
      -- program must share the same Python — that's a hard requirement
      -- of dap-python.
      --
      -- Strategy:
      --   1. Use utils.get_python_path to find the venv Python.
      --   2. If debugpy is missing in a real venv → install it there
      --      (uv pip if present, else pip).
      --   3. If the resolved Python is the system one (no venv) and
      --      debugpy is missing → fall back to Mason's debugpy.
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
        vim.fn.system({ python_path, "-c", "import debugpy" })
        return vim.v.shell_error == 0
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
      require("dap-python").setup(project_python)

      vim.schedule(function()
        if has_debugpy(project_python) then return end

        local venv = venv_root_for(project_python)
        if venv then
          install_into_venv(project_python, function(success)
            if not success then
              local mason = mason_debugpy_python()
              if mason then
                require("dap-python").setup(mason)
                vim.notify("Falling back to Mason debugpy: " .. mason,
                  vim.log.levels.WARN, { title = "nvim-dap-python" })
              end
            end
          end)
        else
          local mason = mason_debugpy_python()
          if mason then
            require("dap-python").setup(mason)
            vim.notify(
              ("No venv detected; using Mason debugpy adapter:\n%s"):format(mason),
              vim.log.levels.INFO, { title = "nvim-dap-python" }
            )
          else
            vim.notify(
              "debugpy is missing and no Mason debugpy available.\nRun :MasonInstall debugpy",
              vim.log.levels.ERROR, { title = "nvim-dap-python", timeout = false }
            )
          end
        end
      end)

      -- ------------------------------------------------------------------
      -- DAP UI lifecycle:
      --   - open on attach/launch
      --   - close automatically only on clean exit
      --   - keep open on errors so you can inspect output
      -- ------------------------------------------------------------------
      local session_state = { had_error = false }

      dap.listeners.before.attach.dapui_config = function()
        session_state.had_error = false
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        session_state.had_error = false
        dapui.open()
      end

      dap.listeners.before.event_exited.dapui_track_error = function(_, body)
        if body and body.exitCode and body.exitCode ~= 0 then
          session_state.had_error = true
        end
      end

      dap.listeners.after.event_output.dapui_track_stderr = function(_, body)
        if body and body.category == "stderr" and body.output and body.output ~= "" then
          session_state.had_error = true
        end
      end

      local function maybe_close_ui()
        if session_state.had_error then
          vim.notify(
            "DAP ended with errors. UI kept open for inspection; close with <leader>Du.",
            vim.log.levels.WARN,
            { title = "DAP" }
          )
          return
        end
        dapui.close()
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        vim.schedule(maybe_close_ui)
      end
      dap.listeners.before.event_exited.dapui_config = function()
        vim.schedule(maybe_close_ui)
      end

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
