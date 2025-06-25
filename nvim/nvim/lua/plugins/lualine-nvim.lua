-- Status line configuration using lualine with a custom modified indicator.
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- for fancy icons
    'linrongbin16/lsp-progress.nvim', -- LSP loading progress
  },
  opts = {
    options = {
      theme = "codedark", -- Themes: auto, tokyonight, catppuccin, codedark, nord, etc.
    },
    sections = {
      lualine_c = {
        -- Custom filename component that shows a modified indicator
        {
          function()
            local filename = vim.fn.expand("%:t") -- get current filename
            if filename == "" then
              return "[No Name]"
            end
            -- Append modified indicator if buffer is unsaved
            if vim.bo.modified then
              return filename .. " [+]"
            else
              return filename
            end
          end,
          icon = " ", -- optional icon before the filename
          color = { gui = "bold" },
          -- additional options can go here
        },
      },
      -- You can keep other sections as-is or add more custom components
    },
  },
}
