-- ============================================
-- Aerial - Outline / Symbols sidebar
-- ============================================
return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    attach_mode = "global",
    layout = {
      default_direction = "right",
      min_width = 30,
      max_width = 45,
    },
  },
  keys = {
    { "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Outline Toggle" },
  },
}
