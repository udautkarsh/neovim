-- ============================================
-- Lualine - Statusline with git branch
-- ============================================

-- Global state for git sync operations
_G.git_sync_status = {
  state = "idle",     -- idle | syncing | success | error
  command = "",       -- pull | push | fetch
  error = "",         -- error message if failed
  start_time = 0,     -- for animation
}

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
          -- Git sync status indicator
          function()
            local status = _G.git_sync_status
            if status.state == "syncing" then
              -- Spinning animation
              local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
              local idx = math.floor((vim.loop.hrtime() / 1e8) % #spinner) + 1
              return spinner[idx]
            elseif status.state == "success" then
              return "✓"
            elseif status.state == "error" then
              return "✗"
            else
              return "●"
            end
          end,
          color = function()
            local status = _G.git_sync_status
            if status.state == "syncing" then
              return { fg = "#00d9ff" }  -- Blue for syncing
            elseif status.state == "success" then
              return { fg = "#00ff9f" }  -- Green for success
            elseif status.state == "error" then
              return { fg = "#ff0055" }  -- Red for error
            else
              return { fg = "#666666" }  -- Gray for idle
            end
          end,
          on_click = function()
            -- Click on error to show details
            if _G.git_sync_status.state == "error" then
              vim.notify(_G.git_sync_status.error, vim.log.levels.ERROR)
            end
          end,
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
