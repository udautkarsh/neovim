-- ============================================
-- LSP Configuration (Neovim 0.11+ native API)
-- ============================================

return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",           -- Lua
        "bashls",           -- Bash/Shell
        "jsonls",           -- JSON
        "yamlls",           -- YAML
        "html",             -- HTML
        "cssls",            -- CSS
        "ts_ls",            -- TypeScript/JavaScript
        "pyright",          -- Python
        "dockerls",         -- Dockerfile
      },
      automatic_installation = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      local servers = require("lsp.servers")
      local on_attach = require("lsp.keymaps").on_attach

      -- LSP capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
      end

      -- Setup each server using vim.lsp.config (Neovim 0.11+ API)
      for server_name, server_opts in pairs(servers) do
        server_opts = server_opts or {}
          server_opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
          server_opts.on_attach = on_attach

        -- Use new vim.lsp.config API
        vim.lsp.config(server_name, server_opts)
      end

      -- Enable all configured servers
      vim.lsp.enable(vim.tbl_keys(servers))

      -- Diagnostic configuration
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
        float = { border = "rounded", source = true },
      })
    end,
  },
}
