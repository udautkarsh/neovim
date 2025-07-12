return {
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { "folke/noice.nvim" }, -- Ensure Noice is loaded before extension
    { "nvim-telescope/telescope-ui-select.nvim" }, -- Added for vim.ui.select integration
  },
  opts = {
    defaults = {
      layout_config = {
        vertical = {
          width = 0.75
        }
      },
      path_display = {
        filename_first = {
          reverse_directories = true
        }
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {}
      }
    }
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("noice")
    require("telescope").load_extension("ui-select") -- Load ui-select extension
  end,
}