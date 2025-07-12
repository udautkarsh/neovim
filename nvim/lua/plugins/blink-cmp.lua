return {
    {
      "saghen/blink.compat",
      version = "*", -- Use the latest release.
      lazy = false,
      opts = {},
    },
    {
      "saghen/blink.cmp",
      dependencies = {
        "rafamadriz/friendly-snippets",
        "moyiz/blink-emoji.nvim",
      },
      version = "1.*",
      opts = {
        keymap = {
          preset = "default",
          -- Use Tab, Enter and Ctrl+Z to accept the selected suggestion.
          ["<Tab>"] = { "accept", "fallback" },
          ["<CR>"]  = { "accept", "fallback" },
          ["<C-Z>"] = { "accept", "fallback" },
        },
        appearance = {
          nerd_font_variant = "mono",
        },
        completion = { documentation = { auto_show = true } },
        signature = { enabled = true },
        sources = {
          default = { "lsp", "path", "snippets", "buffer", "emoji" },
          providers = {
            emoji = {
              module = "blink-emoji",
              name = "Emoji",
              score_offset = 15, -- Adjust ranking as preferred.
              opts = { insert = true },
              should_show_items = function()
                return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
              end,
            },
          },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
      },
      opts_extend = { "sources.default" },
    },
    -- Filetype-specific configuration for Python, Ansible (YAML/YML), and Bash.
    {
      "hrsh7th/nvim-cmp",
      config = function()
        local cmp = require("cmp")
        cmp.setup.filetype("python", {
          sources = cmp.config.sources({
            { name = "lsp", priority = 1000 },
            { name = "snippets", priority = 750 },
            { name = "path", priority = 600 },
            { name = "buffer", priority = 500 },
          }),
        })
        -- For Ansible files, support both 'yaml' and 'yml'
        cmp.setup.filetype({ "yaml", "yml" }, {
          sources = cmp.config.sources({
            { name = "lsp", priority = 1000 },
            { name = "snippets", priority = 750 },
            { name = "buffer", priority = 600 },
            { name = "path", priority = 500 },
          }),
        })
        cmp.setup.filetype("sh", {
          sources = cmp.config.sources({
            { name = "lsp", priority = 1000 },
            { name = "snippets", priority = 750 },
            { name = "buffer", priority = 600 },
            { name = "path", priority = 500 },
          }),
        })
      end,
    },
  }
  