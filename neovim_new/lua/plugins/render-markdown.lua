-- ============================================
-- Render Markdown
-- Makes markdown files more readable in Neovim
-- ============================================

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown", "md" },
  opts = {
    -- Heading configuration
    heading = {
      enabled = true,
      sign = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },
    -- Code block configuration
    code = {
      enabled = true,
      sign = false,
      style = "full",
      left_pad = 2,
      right_pad = 2,
      border = "thin",
    },
    -- Bullet point configuration
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
    },
    -- Checkbox configuration
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰱒 " },
    },
    -- Quote configuration
    quote = {
      enabled = true,
      icon = "▋",
    },
    -- Table configuration
    pipe_table = {
      enabled = true,
      style = "full",
    },
    -- Link configuration
    link = {
      enabled = true,
      image = "󰥶 ",
      hyperlink = "󰌹 ",
    },
    -- Horizontal rule
    dash = {
      enabled = true,
      icon = "─",
    },
  },
}
