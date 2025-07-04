return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    --[[
    lint.linters.yamllint = {
      cmd = "yamllint",
      -- Use the parsable format to ease output parsing
      args = { "-f", "parsable", "-d", "{extends: default, rules: {line-length: {max: 120, level: warning}}}", "-" },
      stdin = true,
      -- Custom parser: Adjust the pattern if needed based on your yamllint output
      parser = require("lint.parser").from_pattern(
        "^([^:]+):(%d+):(%d+): %[(%w+)%] (.+)$",
        { "filename", "lnum", "col", "severity", "message" },
        { warning = vim.diagnostic.severity.WARN,
          error   = vim.diagnostic.severity.ERROR,
          info    = vim.diagnostic.severity.INFO }
      ),
    }
--]]

    lint.linters_by_ft = {
      python = { "pylint" },
      --     yaml   = { "yamllint" },
      json   = { "jsonlint" },
      html   = { "htmlhint" },
      sh     = { "shellcheck" },
      bash   = { "bash" },
      zsh    = { "zsh" },
      ksh    = { "ksh" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChangedI" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
