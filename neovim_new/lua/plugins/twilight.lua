-- ============================================
-- Twilight.nvim - Dim inactive code blocks
-- Highlights only the code you're editing
-- ============================================

return {
  "folke/twilight.nvim",
  event = "VeryLazy",
  opts = {
    dimming = {
      alpha = 0.25, -- Amount of dimming (0 = fully dimmed, 1 = no dimming)
      color = { "Normal", "#ffffff" },
      term_bg = "#000000",
      inactive = false, -- Don't dim inactive windows (Snacks.dim handles that)
    },
    context = 10, -- Amount of lines to show around cursor
    treesitter = true, -- Use treesitter for better context detection
    expand = { -- For these filetypes, expand context
      "function",
      "method",
      "table",
      "if_statement",
      "for_statement",
      "while_statement",
      "class_definition",
    },
    exclude = {}, -- Exclude these filetypes
  },
  keys = {
    { "<leader>tw", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
  },
}
