-- ============================================
-- Mason Tool Installer
-- Auto-install formatters and linters
-- ============================================

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim" },
  event = "VimEnter",
  config = function()
    require("mason")
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",       -- YAML, JSON, Markdown, Web formatter
        "shfmt",          -- Shell formatter
        "stylua",         -- Lua formatter
        "ruff",           -- Python formatter/linter
        "ansible-lint",   -- Ansible linter
        -- "ltex-ls",     -- Requires Java, install manually: :MasonInstall ltex-ls
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 2000,
    })
  end,
}
