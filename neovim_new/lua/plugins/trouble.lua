-- ============================================
-- trouble.nvim - Pretty diagnostics panel
-- ============================================

return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {
    auto_close = false,
    auto_open = false,
    auto_preview = true,
    auto_refresh = true,
    focus = true,
    restore = true,
    follow = true,
    indent_guides = true,
    max_items = 200,
    multiline = true,
    pinned = false,
    warn_no_results = true,
    open_no_results = false,
    win = {
      type = "split",
      position = "bottom",
      size = 10,
    },
    -- Navigation keys inside Trouble (Ctrl+h/j/k/l for window navigation)
    keys = {
      ["<C-k>"] = { action = function() vim.cmd("wincmd k") end, desc = "Go to code window" },
      ["<C-j>"] = { action = function() vim.cmd("wincmd j") end, desc = "Go down" },
      ["<C-h>"] = { action = function() vim.cmd("wincmd h") end, desc = "Go left" },
      ["<C-l>"] = { action = function() vim.cmd("wincmd l") end, desc = "Go right" },
    },
    preview = {
      type = "main",
      scratch = true,
    },
    modes = {
      diagnostics = {
        mode = "diagnostics",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.4,
        },
      },
    },
    icons = {
      indent = {
        top = "│ ",
        middle = "├╴",
        last = "└╴",
        fold_open = " ",
        fold_closed = " ",
        ws = "  ",
      },
      folder_closed = " ",
      folder_open = " ",
      kinds = {
        -- Use default kind icons from LSP
      },
    },
  },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP References (Trouble)" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    { "[x", function()
      if require("trouble").is_open() then
        require("trouble").prev({ skip_groups = true, jump = true })
      else
        local ok, err = pcall(vim.cmd.cprev)
        if not ok then vim.notify(err, vim.log.levels.ERROR) end
      end
    end, desc = "Previous Trouble/Quickfix" },
    { "]x", function()
      if require("trouble").is_open() then
        require("trouble").next({ skip_groups = true, jump = true })
      else
        local ok, err = pcall(vim.cmd.cnext)
        if not ok then vim.notify(err, vim.log.levels.ERROR) end
      end
    end, desc = "Next Trouble/Quickfix" },
  },
}
