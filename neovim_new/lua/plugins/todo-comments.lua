-- ============================================
-- TODO comments - Highlight and jump TODO/FIXME tags
-- ============================================
return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {},
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
    { "<leader>xt", "<cmd>TodoQuickFix<CR>", desc = "TODOs to Quickfix" },
    { "<leader>xT", "<cmd>TodoLocList<CR>", desc = "TODOs to Location list" },
  },
}
