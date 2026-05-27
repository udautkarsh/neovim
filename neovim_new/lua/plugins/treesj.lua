-- ============================================
-- Treesj - Toggle split/join blocks
-- ============================================
return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    { "<leader>j", function() require("treesj").toggle() end, desc = "Join/Split Toggle" },
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = 200,
  },
}
