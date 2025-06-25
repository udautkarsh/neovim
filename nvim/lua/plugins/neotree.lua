return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
  
      source_selector = {
        winbar = true,
        statusline = false,
      },
  
      default_component_configs = {
        container = { enable_character_fade = true },
        indent = {
          indent_size = 2,
          padding = 1,
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = "",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
        },
        git_status = {
          symbols = {
            added     = "A",
            modified  = "M",
            deleted   = "D",
            renamed   = "R",
            untracked = "U",
            ignored   = "I",
            conflict  = "C",
          },
        },
      },
  
      window = {
        position = "left",
        width = 35,
        mappings = {
          ["<space>"] = "toggle_node",
          ["<cr>"]    = "open",
          ["o"]       = "open_with_window_picker",
          ["s"]       = "open_split",
          ["v"]       = "open_vsplit",
          ["t"]       = "open_tabnew",
          ["C"]       = "close_node",
          ["R"]       = "refresh",
          ["a"]       = "add",
          ["d"]       = "delete",
          ["r"]       = "rename",
          ["y"]       = "copy_to_clipboard",
          ["x"]       = "cut_to_clipboard",
          ["p"]       = "paste_from_clipboard",
        },
      },
  
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true,
          never_show = { ".DS_Store", "thumbs.db" },
        },
        follow_current_file = true,
        use_libuv_file_watcher = true,
      },
  
      buffers = {
        follow_current_file = true,
        show_unloaded = true,
      },
  
      git_status = {
        window = {
          position = "float",
          mappings = {
            ["A"]  = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
          },
        },
      },
    },
  
    config = function(_, opts)
      require("neo-tree").setup(opts)
  
      -- Auto-open Neo-tree after launching a real file
      vim.api.nvim_create_autocmd("BufWinEnter", {
        callback = function(args)
          local bufname = vim.api.nvim_buf_get_name(args.buf)
          if bufname ~= "" and vim.fn.isdirectory(bufname) == 0 then
            vim.cmd("Neotree show left filesystem reveal=true")
            vim.api.nvim_del_autocmd(args.id)
          end
        end,
      })
    end,
  }
  