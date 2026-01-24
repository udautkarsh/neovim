-- ============================================
-- Treesitter - Syntax parsing and highlighting
-- Required for neogen, better syntax highlighting
-- ============================================

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",  -- Use stable master branch, not main
  build = ":TSUpdate",
  lazy = false,
  priority = 1000,
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "python", "lua", "bash", "javascript", "typescript",
        "json", "yaml", "markdown", "markdown_inline",
        "html", "css", "dockerfile", "vim", "vimdoc",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      ignore_install = { "snacks_notif" },
    })
  end,
}
