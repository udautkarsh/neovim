return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
	  "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")

      require("dapui").setup({
        layouts = {
          { -- Left panel
            elements = { -- Ordered from top to bottom
              { id = "scopes", size = 0.30 },
              { id = "watches", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "breakpoints", size = 0.20 },
            },
            size = 45,
            position = "left",
          },
          { -- Bottom panel
            elements = { -- Ordered from left to right
              { id = "repl", size = 0.50 },
              { id = "console", size = 0.50 },
            },
            size = 15,
            position = "bottom",
          },
        },
        floating = {
          max_height = 0.90,
          max_width = 0.50,
          border = "rounded",
        },
      })
      require("nvim-dap-virtual-text").setup({
        commented = true, -- Show virtual text alongside comment
      })

      require("mason-nvim-dap").setup({
        ensure_installed = { "python" },
        automatic_installation = true,
      })

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

      local function install_debugpy_into_venv(python_path, on_done)
        local cmd
        if vim.fn.executable("uv") == 1 then
          cmd = { "uv", "pip", "install", "--python", python_path, "debugpy" }
        else
          cmd = { python_path, "-m", "pip", "install", "debugpy" }
        end

        vim.notify(
          ("Installing debugpy into venv: %s"):format(table.concat(cmd, " ")),
          vim.log.levels.INFO,
          { title = "nvim-dap-python" }
        )

        vim.system(cmd, { text = true }, function(res)
          vim.schedule(function()
            if res.code == 0 then
              vim.notify("debugpy installed into project venv.", vim.log.levels.INFO, { title = "nvim-dap-python" })
              on_done(true)
            else
              vim.notify(
                "Failed to install debugpy into venv:\n" .. (res.stderr or res.stdout or "unknown error"),
                vim.log.levels.ERROR,
                { title = "nvim-dap-python", timeout = false }
              )
              on_done(false)
            end
          end)
        end)
      end

      local function mason_debugpy_python()
        local python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
        if vim.fn.executable(python) == 1 then
          return python
        end
        return nil
      end

      local project_python = require("utils").get_python_path(vim.uv.cwd())
      dap_python.setup(project_python)

      vim.schedule(function()
        if has_debugpy(project_python) then
          return
        end

        if venv_root_for(project_python) then
          install_debugpy_into_venv(project_python, function(success)
            if success then
              dap_python.setup(project_python)
              return
            end

            local mason_python = mason_debugpy_python()
            if mason_python then
              dap_python.setup(mason_python)
              vim.notify(
                "Falling back to Mason debugpy: " .. mason_python,
                vim.log.levels.WARN,
                { title = "nvim-dap-python" }
              )
            end
          end)
          return
        end

        local mason_python = mason_debugpy_python()
        if mason_python then
          dap_python.setup(mason_python)
          vim.notify(
            ("No venv detected; using Mason debugpy adapter:\n%s"):format(mason_python),
            vim.log.levels.INFO,
            { title = "nvim-dap-python" }
          )
        else
          vim.notify(
            "debugpy is missing and Mason debugpy is not installed yet.\nRun :MasonInstall debugpy or restart Neovim.",
            vim.log.levels.ERROR,
            { title = "nvim-dap-python", timeout = false }
          )
        end
      end)

      vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapBreakpointRejected", {
        text = "", -- or "❌"
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = "", -- or "→"
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      })

      -- Custom titles applied via `winbar` in each DAP UI window.
      --
      -- NOTE: `dap-repl` is intentionally NOT in this list because
      -- nvim-dap-ui renders its play / pause / step navigation controls
      -- into the REPL window's winbar (controls.element = "repl" is the
      -- default). Setting our own title there hides those buttons.
      local dap_ui_titles = {
        dapui_watches = "DAP Watches",
        dapui_stacks = "DAP Stacks",
        dapui_breakpoints = "DAP Breakpoints",
        dapui_scopes = "DAP Variables",
        dapui_console = "DAP Console",
      }

      local dap_bottom_panels = {
        dapui_console = true,
      }

      local explorer_state = {
        was_open = false,
        cwd = nil,
      }

      local function set_dap_ui_highlights()
        vim.api.nvim_set_hl(0, "DapUITitle", { fg = "#7aa2f7", bold = true })
        vim.api.nvim_set_hl(0, "DapUIWinSeparator", { fg = "#7aa2f7" })
        vim.api.nvim_set_hl(0, "DapUIFloatBorder", { fg = "#7aa2f7" })
        vim.api.nvim_set_hl(0, "DapUIVariable", { bold = true })
        vim.api.nvim_set_hl(0, "DapUIValue", { bold = true })
        vim.api.nvim_set_hl(0, "DapUIScope", { fg = "#7aa2f7", bold = true })
        vim.api.nvim_set_hl(0, "DapUIType", { fg = "#9d7cd8", bold = true })
        vim.api.nvim_set_hl(0, "DapUIDecoration", { fg = "#7aa2f7", bold = true })
        vim.api.nvim_set_hl(0, "DapUIThread", { fg = "#9ece6a", bold = true })
        vim.api.nvim_set_hl(0, "DapUIStoppedThread", { fg = "#7aa2f7", bold = true })
        vim.api.nvim_set_hl(0, "DapUISource", { fg = "#9d7cd8", bold = true })
        vim.api.nvim_set_hl(0, "DapUILineNumber", { fg = "#7aa2f7", bold = true })
        vim.api.nvim_set_hl(0, "DapUIFrameName", { bold = true })
        vim.api.nvim_set_hl(0, "DapUIBreakpointsPath", { fg = "#7aa2f7", bold = true })
        vim.api.nvim_set_hl(0, "DapUIBreakpointsInfo", { fg = "#9ece6a", bold = true })
        vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine", { fg = "#9ece6a", bold = true })
        vim.api.nvim_set_hl(0, "DapUIBreakpointsLine", { fg = "#7aa2f7", bold = true })
        vim.api.nvim_set_hl(0, "DapUIWatchesEmpty", { fg = "#f7768e", bold = true })
        vim.api.nvim_set_hl(0, "DapUIWatchesValue", { fg = "#9ece6a", bold = true })
        vim.api.nvim_set_hl(0, "DapUIWatchesError", { fg = "#f7768e", bold = true })
        vim.api.nvim_set_hl(0, "DapUIFloatNormal", { bold = true })
      end

      -- Returns the list of currently active Snacks explorer pickers, or
      -- nil/empty when none are visible.
      local function get_explorer_pickers()
        local ok, pickers = pcall(function()
          return Snacks.picker.get({ source = "explorer", tab = false })
        end)
        if ok and pickers then
          return pickers
        end
        return {}
      end

      local function get_all_pickers()
        local ok, pickers = pcall(function()
          return Snacks.picker.get({ tab = false })
        end)
        if ok and pickers then
          return pickers
        end
        return {}
      end

      local function explorer_is_visible()
        if #get_explorer_pickers() > 0 then
          return true
        end

        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_is_valid(win) then
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.bo[buf].filetype
            if ft:match("^snacks_") then
              return true
            end
          end
        end

        return false
      end

      local function close_explorer_for_dap()
        local pickers = get_explorer_pickers()
        if #pickers == 0 then
          for _, p in ipairs(get_all_pickers()) do
            if p.opts and p.opts.source == "explorer" then
              pickers[#pickers + 1] = p
            end
          end
        end

        if #pickers == 0 then
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_is_valid(win) then
              local buf = vim.api.nvim_win_get_buf(win)
              local ft = vim.bo[buf].filetype
              if ft:match("^snacks_") then
                explorer_state.was_open = true
                explorer_state.cwd = vim.g.project_root or vim.uv.cwd()
                pcall(vim.api.nvim_win_close, win, true)
              end
            end
          end
        else
          explorer_state.was_open = true
          explorer_state.cwd = vim.g.project_root or vim.uv.cwd()

          -- Close every explorer picker directly via its API. Calling
          -- Snacks.explorer({...}) was unreliable because the source's open
          -- call can re-create the picker instead of toggling it off.
          for _, p in ipairs(pickers) do
            pcall(function()
              if type(p.close) == "function" then
                p:close()
              end
            end)
          end
        end

        if explorer_state.was_open then
          vim.notify("DAP: explorer closed", vim.log.levels.INFO, { title = "DAP" })
        end
      end

      local function restore_explorer_after_dap()
        if not explorer_state.was_open then
          return
        end

        local cwd = explorer_state.cwd or vim.g.project_root or vim.uv.cwd()
        explorer_state.was_open = false
        explorer_state.cwd = nil

        -- Small defer so dapui.close() finishes its window teardown before
        -- the explorer reopens (avoids it landing in a stale layout).
        vim.defer_fn(function()
          if explorer_is_visible() then
            return
          end
          pcall(function()
            Snacks.explorer({ cwd = cwd })
          end)
          vim.notify("DAP: explorer restored", vim.log.levels.INFO, { title = "DAP" })
        end, 250)
      end

      local function dapui_is_visible()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_is_valid(win) then
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.bo[buf].filetype
            if dap_ui_titles[ft] or ft == "dap-repl" then
              return true
            end
          end
        end
        return false
      end

      local function close_dapui_for_explorer()
        if not dapui_is_visible() then
          return
        end
        -- Mark the explorer as "user-opened" so that dapui.close() does
        -- NOT trigger restore_explorer_after_dap re-toggling it off.
        explorer_state.was_open = false
        explorer_state.cwd = nil
        pcall(function()
          dapui.close()
        end)
        vim.notify("Explorer: DAP UI closed", vim.log.levels.INFO, { title = "DAP" })
      end

      local function apply_dap_ui_window_style()
        set_dap_ui_highlights()

        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype
          local title = dap_ui_titles[ft]

          if title then
            local winbar = "%#DapUITitle# " .. title .. " %*"
            if dap_bottom_panels[ft] then
              winbar = "%#DapUIWinSeparator#──────── %#DapUITitle# "
                .. title
                .. " %#DapUIWinSeparator#────────────────────────%*"
            end

            vim.api.nvim_set_option_value(
              "winbar",
              winbar,
              { win = win }
            )
            vim.api.nvim_set_option_value(
              "winhighlight",
              "WinSeparator:DapUIWinSeparator,FloatBorder:DapUIFloatBorder,WinBar:DapUITitle,WinBarNC:DapUITitle",
              { win = win }
            )
          elseif ft == "dap-repl" then
            -- Make sure we don't override the play / pause / step controls
            -- that nvim-dap-ui draws in the REPL's winbar.
            vim.api.nvim_set_option_value(
              "winhighlight",
              "WinSeparator:DapUIWinSeparator,FloatBorder:DapUIFloatBorder",
              { win = win }
            )
          end
        end
      end

      local function toggle_dapui_and_explorer()
        if dapui_is_visible() then
          dapui.close()
          return
        end

        close_explorer_for_dap()
        -- Snacks closes picker layouts on the next scheduled tick. Opening
        -- dap-ui immediately can let the explorer survive in the new layout.
        vim.defer_fn(function()
          dapui.open()
          close_explorer_for_dap()
          apply_dap_ui_window_style()
        end, 250)
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_dap_ui_highlights,
      })

      vim.api.nvim_create_autocmd({ "FileType", "WinEnter", "BufWinEnter" }, {
        pattern = "*",
        callback = function()
          vim.schedule(apply_dap_ui_window_style)
        end,
      })

      -- Close DAP UI when the Snacks explorer is opened.
      -- The FileType `snacks_picker_list` is shared by every Snacks picker
      -- (files, grep, buffers, ...), so we must verify that the picker that
      -- just opened is actually the explorer source before closing dapui.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "snacks_picker_list",
        callback = function()
          vim.schedule(function()
            if explorer_is_visible() then
              close_dapui_for_explorer()
            end
          end)
        end,
      })

      -- ------------------------------------------------------------------
      -- DAP UI lifecycle
      --
      --   event_initialized → open UI, hide explorer, reset error state
      --   stderr captured / non-zero exitCode → mark session as errored
      --   event_terminated / event_exited:
      --     - clean   → dapui.close() (User DapUIClose → explorer restored)
      --     - errored → KEEP UI open so the message in REPL / console can
      --                 be read. Explorer is restored later when the user
      --                 closes the UI manually (<leader>du / <A-S-d>).
      -- ------------------------------------------------------------------
      local session_state = { had_error = false }

      dap.listeners.after.event_initialized["dapui_config"] = function()
        session_state.had_error = false
        close_explorer_for_dap()
        vim.defer_fn(function()
          dapui.open()
          close_explorer_for_dap()
          apply_dap_ui_window_style()
        end, 80)
      end

      dap.listeners.before.event_exited["dap_track_exit_code"] = function(_, body)
        if body and body.exitCode and body.exitCode ~= 0 then
          session_state.had_error = true
        end
      end

      dap.listeners.after.event_output["dap_track_stderr"] = function(_, body)
        if body and body.category == "stderr" and body.output and body.output ~= "" then
          session_state.had_error = true
        end
      end

      local function maybe_close_dapui_on_session_end()
        vim.schedule(function()
          if session_state.had_error then
            vim.notify(
              "DAP session ended with errors. UI kept open — close with <leader>du.",
              vim.log.levels.WARN,
              { title = "DAP" }
            )
            return
          end
          pcall(function()
            dapui.close()
          end)
        end)
      end
      dap.listeners.before.event_terminated["dapui_config"] = maybe_close_dapui_on_session_end
      dap.listeners.before.event_exited["dapui_config"] = maybe_close_dapui_on_session_end

      -- Whenever the DAP UI is opened by ANY path (debug session start,
      -- manual <leader>Du / <A-S-d>, etc.), hide the explorer.
      vim.api.nvim_create_autocmd("User", {
        pattern = "DapUIOpen",
        callback = function()
          vim.schedule(function()
            close_explorer_for_dap()
            apply_dap_ui_window_style()
          end)
        end,
      })

      -- Whenever the DAP UI actually closes (manual <leader>du OR the
      -- auto-close above), restore the explorer if we hid it.
      vim.api.nvim_create_autocmd("User", {
        pattern = "DapUIClose",
        callback = restore_explorer_after_dap,
      })

      local opts = { noremap = true, silent = true }

      -- Toggle breakpoint
      vim.keymap.set("n", "<leader>Db", function()
        dap.toggle_breakpoint()
      end, opts)

      -- Continue / Start
      vim.keymap.set("n", "<leader>Dc", function()
        dap.continue()
      end, opts)

      -- Step Over
      vim.keymap.set("n", "<leader>Do", function()
        dap.step_over()
      end, opts)

      -- Step Into
      vim.keymap.set("n", "<leader>Di", function()
        dap.step_into()
      end, opts)

      -- Step Out
      vim.keymap.set("n", "<leader>DO", function()
        dap.step_out()
      end, opts)
			
      -- Keymap to terminate debugging
	  vim.keymap.set("n", "<leader>Dq", function()
	      require("dap").terminate()
      end, opts)

      -- Toggle DAP UI
      vim.keymap.set("n", "<leader>Du", function()
        toggle_dapui_and_explorer()
      end, opts)

      -- Fast Alt shortcuts
      vim.keymap.set("n", "<A-d>", function()
        dap.toggle_breakpoint()
      end, opts)

      -- Different terminals report Alt+Shift+d as either <A-S-d> or <A-D>.
      vim.keymap.set("n", "<A-S-d>", function()
        toggle_dapui_and_explorer()
      end, opts)
      vim.keymap.set("n", "<A-D>", function()
        toggle_dapui_and_explorer()
      end, opts)
    end,
  },
}

