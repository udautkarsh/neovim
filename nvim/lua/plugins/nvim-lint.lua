return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    local pylint = lint.linters.pylint

    lint.linters_by_ft = {
      python = { "pylint" },
      json   = { "jsonlint" },
      html   = { "htmlhint" },
      sh     = { "shellcheck" },
      bash   = { "bash" },
      zsh    = { "zsh" },
      ksh    = { "ksh" },
    }

    pylint.args = {
      "-f", 
      "json", -- Use colored output
      "--max-line-length=120", 
      "--ignore-comments", "yes", 
      "--from-stdin",
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChangedI" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}