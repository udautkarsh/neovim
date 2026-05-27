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
      { "<leader>d", group = "LSP Navigation" },
      -- Debug (DAP) — full tree so which-key lists them after <Space>
      -- (capital D = Shift+D; lazy.nvim keys alone are not always discovered)
      { "<leader>D", group = "Debug", icon = "🐞" },
      { "<leader>Dc", desc = "Continue / Start" },
      { "<leader>Dn", desc = "Step Over (next)" },
      { "<leader>Ds", desc = "Step Into" },
      { "<leader>Dr", desc = "Step Out (return)" },
      { "<leader>Dq", desc = "Terminate" },
      { "<leader>Db", desc = "Toggle Breakpoint" },
      { "<leader>DB", desc = "Conditional Breakpoint" },
      { "<leader>Dp", desc = "Print / Evaluate" },
      { "<leader>DC", desc = "Run to Cursor" },
      { "<leader>Dl", desc = "Run Last Config" },
      { "<leader>DL", desc = "Pick Launch Config" },
      { "<leader>DF", desc = "Select Python File" },
      { "<leader>Du", desc = "Toggle Debug UI" },
      { "<leader>DR", desc = "Toggle REPL" },
      { "<leader>Dt", desc = "Debug Test Method" },
      { "<leader>DT", desc = "Debug Test Class" },
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
