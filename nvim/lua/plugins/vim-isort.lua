return {
  -- https://github.com/fisadev/vim-isort
  'fisadev/vim-isort',
  lazy = false,
  ft = 'python',
  config = function()
    -- Disable default key binding
    vim.g.vim_isort_map = ''

    -- Automatically format file buffer when saving
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      pattern = "*.py",
      callback = function()
        vim.cmd("Isort")
      end,
    })
  end
}
