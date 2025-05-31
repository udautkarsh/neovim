
-- Neogen: A code annotation generator for Neovim
--   enabled = true,
--   snippet_engine = "luasnip", -- or "vsnip", "snippy", "ultisnips"
--   filetypes = { "python", "javascript", "typescript", "lua", "go" }, -- Add more filetypes as needed
--             },   
return {
    "danymat/neogen",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("neogen").setup({
        enabled = true,
        snippet_engine = "luasnip", -- or "vsnip", "snippy", "ultisnips"
        filetypes = { "python", "javascript", "typescript", "lua", "go" }, -- Add more filetypes as needed
        languages = {
          python = {
            template = {
              annotation_convention = "google_docstrings",
            },
          },
          javascript = {
            template = {
              annotation_convention = "jsdoc",
            },
          },
          typescript = {
            template = {
              annotation_convention = "tsdoc",
            },
          },
          lua = {
            template = {
              annotation_convention = "lua_doc",
            },
          },
          go = {
            template = {
              annotation_convention = "go_doc",
            },
          },
        },
      })
    end,
    -- Optional: load on command or keymap
    cmd = { "Neogen" },
    keys = {
      { "<leader>ng", function() require("neogen").generate() end, desc = "Generate docstring" },
    },
  }
