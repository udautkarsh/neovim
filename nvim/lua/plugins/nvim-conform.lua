return {
  'stevearc/conform.nvim',
  lazy = false,
  event = { "BufWritePre" },
  opts = {
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_format" },  -- Only Ruff tools
    },

    formatters = {
      -- Ruff fix configuration (handles linting and import sorting)
      ruff_fix = {
        command = "ruff",
        args = {
          "check",
          "--fix",
          "--line-length=100",
          "--extend-select=I",  -- Enable import sorting
          "--stdin-filename",
          "$FILENAME",
          "-",
        },
      },

      -- Ruff format configuration (handles code formatting)
      ruff_format = {
        command = "ruff",
        args = {
          "format",
          "--line-length=100",
          "--stdin-filename",
          "$FILENAME",
          "-",
        },
      },
    },

    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}