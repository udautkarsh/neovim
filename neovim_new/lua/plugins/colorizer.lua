-- ============================================
-- Colorizer - Inline color preview (hex, rgb, tailwind)
-- ============================================
return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    user_default_options = {
      tailwind = true,
      names = false,
    },
  },
}
