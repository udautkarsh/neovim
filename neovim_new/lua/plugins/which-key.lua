-- ============================================
-- which-key.nvim - Shows keybindings as you type
-- ============================================

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix", -- helix, modern, classic
    delay = 300, -- Show popup after 300ms delay
    icons = {
      mappings = true,
      rules = {},
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    win = {
      border = "rounded",
      padding = { 1, 2 },
      title = true,
      title_pos = "center",
    },
    layout = {
      width = { min = 20, max = 50 },
      spacing = 3,
    },
    -- Document key groups
    spec = {
      { "<leader>f", group = "Find/Files" },
      { "<leader>g", group = "Git" },
      { "<leader>gh", group = "Git Hunks" },
      { "<leader>b", group = "Buffers" },
      { "<leader>d", group = "Code Navigation" },
      { "<leader>D", group = "DAP Debug" },
      -- DAP keymaps (defined in lua/plugins/dap.lua):
      --   <leader>Db = Toggle Breakpoint
      --   <leader>Dc = Continue / Start
      --   <leader>Do = Step Over
      --   <leader>Di = Step Into
      --   <leader>DO = Step Out
      --   <leader>Dq = Terminate
      --   <leader>Du = Toggle DAP UI
      { "<leader>c", group = "Code" },
      { "<leader>u", group = "UI/Toggle" },
      { "<leader>t", group = "Toggle/Terminal" },
      { "<leader>w", group = "Workspace" },
      { "<leader>x", group = "Diagnostics" },
      { "<leader>s", group = "Split" },
      { "<leader>r", group = "Rename" },
      { "<leader>p", group = "Profiler" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Keymaps (which-key)",
    },
  },
}
