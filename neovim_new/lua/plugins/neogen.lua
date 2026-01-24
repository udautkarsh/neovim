-- ============================================
-- Neogen - Docstring Generator
-- Generate docstrings for Python, JS, etc.
-- Requires LuaSnip as snippet engine
-- ============================================

return {
  -- LuaSnip - Snippet Engine (required by neogen)
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    lazy = false,  -- Load immediately so neogen can use it
    config = function()
      require("luasnip").setup({})
    end,
  },

  -- Neogen - Docstring Generator
  {
    "danymat/neogen",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
    },
    cmd = "Neogen",
    keys = {
      {
        "<leader>nd",
        function()
          require("neogen").generate()
        end,
        desc = "Generate Docstring (auto-detect)",
      },
    },
    config = function()
      require("neogen").setup({
        enabled = true,
        snippet_engine = "luasnip",
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
              annotation_convention = "emmylua",
            },
          },
        },
      })
    end,
  },
}
