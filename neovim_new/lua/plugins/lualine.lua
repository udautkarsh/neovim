-- ============================================
-- Lualine - Statusline with git branch
-- ============================================

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "auto",  -- Auto-detect theme from colorscheme (Kanagawa)
      globalstatus = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          "branch",
          icon = "",
          color = { fg = "#00d9ff", gui = "bold" },
        },
        {
          "diff",
          symbols = { added = " ", modified = " ", removed = " " },
          diff_color = {
            added = { fg = "#00ff9f" },
            modified = { fg = "#00d9ff" },
            removed = { fg = "#ff0055" },
          },
        },
      },
      lualine_c = {
        {
          "filename",
          path = 1, -- Relative path
          symbols = {
            modified = " ●",
            readonly = " ",
            unnamed = "[No Name]",
          },
        },
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
        },
      },
      lualine_x = {
        "encoding",
        {
          "fileformat",
          symbols = { unix = "", dos = "", mac = "" },
        },
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
