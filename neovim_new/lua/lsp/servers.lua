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
  -- Dynamic venv: `before_init` runs per-workspace, so pyright always uses
  -- the venv interpreter found under the current project root.
  pyright = {
    before_init = function(_, config)
      local utils = require("utils")
      local root = config.root_dir or vim.uv.cwd()
      local python_path = utils.get_python_path(root)

      config.settings = config.settings or {}
      config.settings.python = vim.tbl_deep_extend(
        "force",
        config.settings.python or {},
        { pythonPath = python_path }
      )

      -- Also expose venvPath/venv (pyright honors these for import resolution)
      local venv_env = os.getenv("VIRTUAL_ENV")
      if venv_env and venv_env ~= "" then
        config.settings.python.venvPath = vim.fs.dirname(venv_env)
        config.settings.python.venv = vim.fs.basename(venv_env)
      end
    end,
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
