return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Load only when an LSP server attaches
    priority = 1000,      -- Ensure it loads after other visuals are ready
    config = function()
      -- Disable default virtual_text to prevent duplicate messages
      vim.diagnostic.config({ virtual_text = false })
  
      require("tiny-inline-diagnostic").setup({
        preset = "modern", -- "classic", "ghost", "minimal", etc.
        transparent_bg = false,
        hi = {
          error       = "DiagnosticError",
          warn        = "DiagnosticWarn",
          info        = "DiagnosticInfo",
          hint        = "DiagnosticHint",
          arrow       = "NonText",
          background  = "CursorLine",
        },
        options = {
          show_source = { enabled = false },       -- Toggle LSP source display
          use_icons_from_diagnostic = false,       -- Prefer style over LSP icons
          add_messages = true,                     -- Show the actual message
        },
      })
    end,
  }
  