return ({
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
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
          git = true,
        },
        glyphs = {
          git = {
            unstaged  = "M",  -- Modified
            staged    = "A",  -- Added
            unmerged  = "U",  -- Unmerged / conflicted
            renamed   = "R",  -- Renamed
            untracked = "?",  -- Untracked
            deleted   = "D",  -- Deleted
            ignored   = "I",  -- Ignored
          },
        },
      },
    },
    git = {
      enable = true,       -- Enable Git integration
      ignore = false,      -- Do not hide files listed in .gitignore
      show_on_dirs = true, -- Show Git status on directories as well
      timeout = 400,
    },
    filters = {
      dotfiles = true,
    },
    actions = {
      open_file = {
        window_picker = {
          enable = true,
        },
        quit_on_open = false, -- Keep nvim-tree open after a file is opened
      },
    },
  },
  config = function(_, opts)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup(opts)
    require("nvim-web-devicons").setup({
      override = {},
      default = true,
    })
  end,
})
