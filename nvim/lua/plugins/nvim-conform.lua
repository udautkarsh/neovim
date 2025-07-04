-- is for formatting(fixes/aligns code) and not linting (reporting suggestions in editor). For linting use nvim-lint
--[[
-- using black formatter
return {
  'stevearc/conform.nvim',
  lazy = false,
  event = { "BufWritePre" },
  opts = {
    formatters_by_ft = {
      python = { "black" },
    },

    formatters = {
      black = {
        command = "black",
        args = {
          "--quiet",             -- suppress output unless errors occur
          "--line-length", "79", -- set maximum line length
          "-",
        },
        stdin = true,
      },
    },

    format_on_save = {
      timeout_ms = 2000,
      lsp_format = "fallback",
    },
  },
}
--]]
-- using ruff

return {
  'stevearc/conform.nvim',
  lazy = false,
  event = { "BufWritePre" },
  opts = {
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_format" }, -- Added pylint here
      yaml = { "prettier" },
    },

    formatters = {
      -- Ruff fix configuration (handles linting and import sorting)
      ruff_fix = {
        command = "ruff",
        args = {
          "check",
          "--fix",
          "--line-length=79",
          "--extend-select=I", -- Enable import sorting
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
          "--line-length=79",
          "--stdin-filename",
          "$FILENAME",
          "-",
        },
      },
    },
    prettier = {
      command = "prettier",
      args = {
        "--config", vim.fn.expand("~/.config/nvim/files/.prittierrc.yaml"),
        "--parser", "yaml",
      },
      stdin = true,
    },


    -- Format on save configuration
    format_on_save = {
      timeout_ms = 2000,
      lsp_format = "fallback",
    },
  },
}
