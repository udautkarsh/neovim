-- ============================================
-- lspsaga.nvim - Enhanced LSP UI
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
    -- Lightbulb for code actions
    lightbulb = {
      enable = true,
      sign = true,
      virtual_text = false,
      debounce = 10,
      sign_priority = 40,
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
    -- Peek/Goto Definition
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
    -- Finder (references, implementations)
    finder = {
      max_height = 0.5,
      left_width = 0.3,
      right_width = 0.4,
      default = "ref+imp+def",
      layout = "float",
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
    -- Diagnostics
    diagnostic = {
      show_code_action = true,
      show_layout = "float",
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
  keys = {
    -- Peek Definition (floating window)
    { "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
    -- Go to Definition
    { "<leader>gD", "<cmd>Lspsaga goto_definition<CR>", desc = "Go to Definition" },
    -- Peek Type Definition
    { "<leader>gt", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Peek Type Definition" },
    -- Go to Type Definition
    { "<leader>gT", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Go to Type Definition" },
    -- Finder (references + implementations)
    { "<leader>gf", "<cmd>Lspsaga finder<CR>", desc = "LSP Finder" },
    -- Code Action
    { "<leader>ca", "<cmd>Lspsaga code_action<CR>", mode = { "n", "v" }, desc = "Code Action" },
    -- Rename
    { "<leader>cr", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
    -- Rename (project-wide)
    { "<leader>cR", "<cmd>Lspsaga rename ++project<CR>", desc = "Rename (Project)" },
    -- Hover Doc
    { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover Doc" },
    -- Show Line Diagnostics
    { "<leader>cD", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Line Diagnostics" },
    -- Show Cursor Diagnostics
    { "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "Cursor Diagnostics" },
    -- Diagnostic Jump
    { "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Prev Diagnostic" },
    { "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
    -- Outline
    { "<leader>co", "<cmd>Lspsaga outline<CR>", desc = "Code Outline" },
    -- Call Hierarchy
    { "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", desc = "Incoming Calls" },
    { "<leader>cO", "<cmd>Lspsaga outgoing_calls<CR>", desc = "Outgoing Calls" },
  },
}
