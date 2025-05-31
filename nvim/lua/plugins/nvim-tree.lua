return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  opts = {
    sort_by = "case_sensitive",
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
      highlight_opened_files = "all", -- Highlight recently opened files like VS Code
      icons = {
        show = {
          git = false, -- Hide Git indicators for a cleaner UI
        }
      }
    },
    filters = {
      dotfiles = true,
    },
    actions = {
      open_file = {
        window_picker = {
          enable = true
        },
        quit_on_open = false, -- Keep nvim-tree open after opening a file
      }
    },
  },
  config = function (_, opts)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup(opts)

    -- Auto-open nvim-tree when Neovim starts without a file
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if vim.fn.argc() == 0 then
          require("nvim-tree.api").tree.open()
        end
      end
    })

    -- Ensure nvim-web-devicons is properly configured
    require("nvim-web-devicons").setup({
      override = {},
      default = true,
    })
  end
}
