-- ============================================
-- iron.nvim - REPL integration (Python)
-- ============================================

return {
  "Vigemus/iron.nvim",
  event = "VeryLazy",
  config = function()
    local iron = require("iron.core")
    local iron_config = require("iron.config")

    local function ipython_repl()
      if vim.fn.executable("ipython") == 1 then
        return { command = { "ipython" } }
      end
      vim.notify("ipython not found, falling back to python3", vim.log.levels.WARN)
      return { command = { "python3" } }
    end

    local function jupyter_repl()
      if vim.fn.executable("jupyter") == 1 then
        return { command = { "jupyter", "console", "--kernel", "python" } }
      end
      vim.notify("jupyter not found, falling back to python3", vim.log.levels.WARN)
      return { command = { "python3" } }
    end

    iron.setup({
      config = {
        repl_definition = {
          python = ipython_repl(),
        },
        repl_open_cmd = "vertical botright 60 split",
        -- repl_open_cmd = "horizontal botright 15 split",
      },
      keymaps = {
        send_motion = "<leader>ic",
        visual_send = "<leader>ic",
        send_file = "<leader>if",
        send_line = "<leader>il",
        send_until_cursor = "<leader>iu",
        send_mark = "<leader>im",
        mark_motion = "<leader>imc",
        mark_visual = "<leader>imc",
        remove_mark = "<leader>imd",
        cr = "<leader>i<CR>",
        interrupt = "<leader>i<space>",
        exit = "<leader>iq",
        clear = "<leader>iC",
      },
      highlight = { italic = true },
      ignore_blank_lines = true,
    })

    local function ensure_python_repl()
      local ok = pcall(iron.focus_on, "python")
      if not ok then
        pcall(iron.repl_for, "python")
      end
    end

    local function set_python_repl(repl)
      iron_config.repl_definition.python = repl
      ensure_python_repl()
      pcall(vim.cmd, "IronRestart")
    end

    vim.keymap.set("n", "<leader>is", function()
      iron.repl_for("python")
    end, { desc = "Iron: start REPL" })
    vim.keymap.set("n", "<leader>ir", function()
      ensure_python_repl()
      pcall(vim.cmd, "IronRestart")
    end, { desc = "Iron: restart REPL" })
    vim.keymap.set("n", "<leader>iR", function()
      iron.focus_on("python")
    end, { desc = "Iron: focus REPL" })
    vim.keymap.set("n", "<leader>iH", function()
      iron.hide_repl("python")
    end, { desc = "Iron: hide REPL" })
    vim.keymap.set("n", "<leader>ii", function()
      set_python_repl(ipython_repl())
    end, { desc = "Iron: use ipython" })
    vim.keymap.set("n", "<leader>ij", function()
      set_python_repl(jupyter_repl())
    end, { desc = "Iron: use jupyter console" })
  end,
}
