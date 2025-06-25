return {
  -- LuaSnip is required by Neogen to generate snippets
  { "L3MON4D3/LuaSnip", version = "1.*" },
  {
    "danymat/neogen",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip", -- Ensure LuaSnip is loaded
    },
    config = function()
      require("neogen").setup({
        enabled = true,
        snippet_engine = "luasnip", -- You can change this to "vsnip", "snippy", "ultisnips" if needed
        filetypes = { "python", "javascript", "typescript", "lua", "go" },
        languages = {
          python = {
            template = {
              annotation_convention = "google_docstrings",
              function_template = {
                description = "Function description goes here.",
                args = "Parameters:",
                returns = "Returns:",
                raises = "Raises:",
              },
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
    -- Optional: load on command or keymap.
    cmd = { "Neogen" },
    keys = {
      { "<leader>ng", function() require("neogen").generate() end, desc = "Generate docstring" },
    },
  },
}
