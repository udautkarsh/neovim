-- ============================================
-- Render Markdown
-- Makes markdown files more readable in Neovim
-- ============================================
-- To change the look:
--   1. Pick ONE palette from the PALETTES table below
--   2. Set `active_palette` to its name (string)
--   3. Save and re-open the markdown file
--
-- Want to tweak colors? Edit any palette entry — or duplicate one and
-- rename it. Each palette defines 6 heading backgrounds (h1_bg..h6_bg),
-- 6 heading foregrounds (h1_fg..h6_fg), and a code block bg (code_bg).
-- Use the string "none" for any field to disable that background.
-- ============================================

local PALETTES = {
  -- Warm dark, slightly purple tint. Pairs well with Kanagawa,
  -- Tokyonight-night, Gruvbox-dark, Catppuccin Frappe.
  kanagawa_warm = {
    h1_bg = "#363646", h2_bg = "#2a2a37", h3_bg = "#252535",
    h4_bg = "#22222e", h5_bg = "#1f1f28", h6_bg = "#1c1c25",
    h1_fg = "#7E9CD8", h2_fg = "#7FB4CA", h3_fg = "#98BB6C",
    h4_fg = "#E6C384", h5_fg = "#FFA066", h6_fg = "#D27E99",
    code_bg = "#1f1f28",
  },

  -- Cool blues, low contrast. Pairs well with Tokyonight (any flavor).
  tokyonight_blue = {
    h1_bg = "#283457", h2_bg = "#2a3148", h3_bg = "#283042",
    h4_bg = "#252b3a", h5_bg = "#1f2335", h6_bg = "#1a1b26",
    h1_fg = "#7aa2f7", h2_fg = "#bb9af7", h3_fg = "#7dcfff",
    h4_fg = "#9ece6a", h5_fg = "#e0af68", h6_fg = "#f7768e",
    code_bg = "#1a1b26",
  },

  -- Pastel, soft, no harsh contrast. Pairs well with Catppuccin Mocha.
  catppuccin_mocha = {
    h1_bg = "#313244", h2_bg = "#2a2b3c", h3_bg = "#262737",
    h4_bg = "#222232", h5_bg = "#1e1e2e", h6_bg = "#181825",
    h1_fg = "#f38ba8", h2_fg = "#fab387", h3_fg = "#f9e2af",
    h4_fg = "#a6e3a1", h5_fg = "#89dceb", h6_fg = "#cba6f7",
    code_bg = "#181825",
  },

  -- Warm browns/oranges. Pairs well with Gruvbox-dark, EveryForest.
  gruvbox_warm = {
    h1_bg = "#3c3836", h2_bg = "#32302f", h3_bg = "#2a2826",
    h4_bg = "#242220", h5_bg = "#1d2021", h6_bg = "#181816",
    h1_fg = "#fb4934", h2_fg = "#fabd2f", h3_fg = "#b8bb26",
    h4_fg = "#8ec07c", h5_fg = "#83a598", h6_fg = "#d3869b",
    code_bg = "#1d2021",
  },

  -- Pure greys, only icon color changes. Most subtle option.
  monochrome = {
    h1_bg = "#2e2e2e", h2_bg = "#2a2a2a", h3_bg = "#262626",
    h4_bg = "#222222", h5_bg = "#1e1e1e", h6_bg = "#1a1a1a",
    h1_fg = "#e6e6e6", h2_fg = "#d0d0d0", h3_fg = "#b8b8b8",
    h4_fg = "#a0a0a0", h5_fg = "#888888", h6_fg = "#707070",
    code_bg = "#1c1c1c",
  },

  -- No heading backgrounds. Just colored icons + bold text.
  -- Cleanest look for terminals with transparent backgrounds.
  minimal = {
    h1_bg = "none", h2_bg = "none", h3_bg = "none",
    h4_bg = "none", h5_bg = "none", h6_bg = "none",
    h1_fg = "#7E9CD8", h2_fg = "#7FB4CA", h3_fg = "#98BB6C",
    h4_fg = "#E6C384", h5_fg = "#FFA066", h6_fg = "#D27E99",
    code_bg = "#1f1f28",
  },

  -- Solarized Dark inspired (low-contrast, warm).
  solarized_dark = {
    h1_bg = "#073642", h2_bg = "#0a3a47", h3_bg = "#0b3e4c",
    h4_bg = "#0d4250", h5_bg = "#0e4854", h6_bg = "#104a58",
    h1_fg = "#268bd2", h2_fg = "#2aa198", h3_fg = "#859900",
    h4_fg = "#b58900", h5_fg = "#cb4b16", h6_fg = "#d33682",
    code_bg = "#002b36",
  },
}

-- ⬇⬇  CHANGE THIS LINE TO PICK A PALETTE  ⬇⬇
local active_palette = "kanagawa_warm"
-- Options: "kanagawa_warm" | "tokyonight_blue" | "catppuccin_mocha"
--       | "gruvbox_warm"   | "monochrome"     | "minimal"
--       | "solarized_dark"

local palette = PALETTES[active_palette] or PALETTES.kanagawa_warm

-- Convert palette entry to a value the highlight API accepts.
-- "none" / nil / "" -> "NONE" (transparent); anything else stays as-is.
local function norm(color)
  if color == nil or color == "" or string.lower(tostring(color)) == "none" then
    return "NONE"
  end
  return color
end

local function apply_markdown_highlights()
  local hl = vim.api.nvim_set_hl

  -- Heading backgrounds (used by render-markdown)
  hl(0, "RenderMarkdownH1Bg", { bg = norm(palette.h1_bg) })
  hl(0, "RenderMarkdownH2Bg", { bg = norm(palette.h2_bg) })
  hl(0, "RenderMarkdownH3Bg", { bg = norm(palette.h3_bg) })
  hl(0, "RenderMarkdownH4Bg", { bg = norm(palette.h4_bg) })
  hl(0, "RenderMarkdownH5Bg", { bg = norm(palette.h5_bg) })
  hl(0, "RenderMarkdownH6Bg", { bg = norm(palette.h6_bg) })

  -- Heading foregrounds (icon + signs)
  hl(0, "RenderMarkdownH1", { fg = norm(palette.h1_fg), bold = true })
  hl(0, "RenderMarkdownH2", { fg = norm(palette.h2_fg), bold = true })
  hl(0, "RenderMarkdownH3", { fg = norm(palette.h3_fg), bold = true })
  hl(0, "RenderMarkdownH4", { fg = norm(palette.h4_fg), bold = true })
  hl(0, "RenderMarkdownH5", { fg = norm(palette.h5_fg), bold = true })
  hl(0, "RenderMarkdownH6", { fg = norm(palette.h6_fg), bold = true })

  -- Code block background
  hl(0, "RenderMarkdownCode", { bg = norm(palette.code_bg) })
end

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown", "md" },
  init = function()
    -- Apply highlights on startup AND whenever the colorscheme changes,
    -- so a theme switch (e.g. :colorscheme tokyonight) doesn't wipe them.
    apply_markdown_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("user.render_markdown.hl", { clear = true }),
      callback = apply_markdown_highlights,
    })
  end,
  opts = {
    heading = {
      enabled = true,
      sign = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },
    code = {
      enabled = true,
      sign = false,
      style = "full",
      left_pad = 2,
      right_pad = 2,
      border = "thin",
      highlight = "RenderMarkdownCode",
    },
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
    },
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰱒 " },
    },
    quote = {
      enabled = true,
      icon = "▋",
    },
    pipe_table = {
      enabled = true,
      style = "full",
    },
    link = {
      enabled = true,
      image = "󰥶 ",
      hyperlink = "󰌹 ",
    },
    dash = {
      enabled = true,
      icon = "─",
    },
  },
}
