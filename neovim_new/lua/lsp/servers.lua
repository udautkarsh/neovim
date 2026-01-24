-- ============================================
-- LSP Server Configurations
-- ============================================

return {
  -- Lua
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
        completion = { callSnippet = "Replace" },
        telemetry = { enable = false },
        diagnostics = { globals = { "vim", "Snacks" } },
      },
    },
  },

  -- Bash
  bashls = {},

  -- Python
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
  },

  -- JSON
  jsonls = {
    settings = {
      json = { validate = { enable = true } },
    },
  },

  -- YAML
  yamlls = {
    settings = {
      yaml = { keyOrdering = false },
    },
  },

  -- TypeScript/JavaScript
  ts_ls = {},

  -- Docker
  dockerls = {},

  -- HTML
  html = {},

  -- CSS
  cssls = {},

  -- Go
  gopls = {
    settings = {
      gopls = {
        analyses = { unusedparams = true },
        staticcheck = true,
        gofumpt = true,
      },
    },
  },

  -- Rust
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = { command = "clippy" },
      },
    },
  },

}
