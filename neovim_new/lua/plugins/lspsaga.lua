-- ============================================
-- lspsaga.nvim - Enhanced LSP UI (latest version)
-- ============================================

return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- Symbol in winbar (breadcrumb)
    symbol_in_winbar = {
      enable = true,
      separator = " › ",
      hide_keyword = true,
      show_file = true,
      folder_level = 1,
      color_mode = true,
    },
    -- Lightbulb disabled for speed
    lightbulb = {
      enable = false,
    },
    -- Code action
    code_action = {
      num_shortcut = true,
      show_server_name = true,
      extend_gitsigns = true,
      keys = {
        quit = { "q", "<Esc>" },
        exec = "<CR>",
      },
    },
    -- Peek/Goto Definition (stacked windows)
    definition = {
      keys = {
        edit = "<CR>",
        vsplit = "v",
        split = "s",
        tabe = "t",
        quit = "q",
        close = "<Esc>",
      },
    },
    -- Finder (references, implementations) - stacked
    finder = {
      max_height = 0.5,
      left_width = 0.3,
      right_width = 0.4,
      default = "ref+imp+def",
      layout = "float",  -- This enables floating/stacked windows
      keys = {
        shuttle = "[w",
        toggle_or_open = "<CR>",
        vsplit = "v",
        split = "s",
        tabe = "t",
        tabnew = "T",
        quit = "q",
        close = "<Esc>",
      },
    },
    -- Hover documentation
    hover = {
      max_width = 0.6,
      max_height = 0.6,
      open_link = "gx",
      open_cmd = "!open",
    },
    -- Rename
    rename = {
      in_select = true,
      auto_save = false,
      project_max_width = 0.5,
      project_max_height = 0.5,
      keys = {
        quit = "<Esc>",
        exec = "<CR>",
        select = "x",
      },
    },
    -- Diagnostics (stacked floating)
    diagnostic = {
      show_code_action = true,
      show_layout = "float",  -- Floating layout for stacked windows
      show_normal_height = 10,
      jump_num_shortcut = true,
      max_width = 0.7,
      max_height = 0.6,
      text_hl_follow = true,
      border_follow = true,
      extend_relatedInformation = false,
      diagnostic_only_current = false,
      keys = {
        exec_action = "o",
        quit = "q",
        quit_in_show = { "q", "<Esc>" },
        toggle_or_jump = "<CR>",
      },
    },
    -- Outline
    outline = {
      win_position = "right",
      win_width = 30,
      auto_preview = true,
      detail = true,
      auto_close = true,
      close_after_jump = false,
      layout = "normal",
      max_height = 0.5,
      left_width = 0.3,
      keys = {
        toggle_or_jump = "<CR>",
        quit = "q",
        jump = "e",
      },
    },
    -- Callhierarchy
    callhierarchy = {
      show_detail = false,
      keys = {
        edit = "e",
        vsplit = "v",
        split = "s",
        tabe = "t",
        close = "<Esc>",
        quit = "q",
        shuttle = "[w",
        toggle_or_req = "u",
      },
    },
    -- UI settings
    ui = {
      border = "rounded",
      devicon = true,
      title = true,
      expand = "⊞",
      collapse = "⊟",
      code_action = "💡",
      actionfix = " ",
      lines = { "┗", "┣", "┃", "━", "┏" },
      imp_sign = "󰳛 ",
    },
    -- Scroll in preview
    scroll_preview = {
      scroll_down = "<C-d>",
      scroll_up = "<C-u>",
    },
  },
  -- Keymaps are defined in lsp/keymaps.lua
}
