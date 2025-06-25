-- Code Tree Support / Syntax Highlighting
return {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  'nvim-treesitter/nvim-treesitter',
  event = "BufReadPre",
  dependencies = {
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  opts = {
    highlight = {
      enable = true,
    },
    indent = { enable = true },
    auto_install = true, -- automatically install syntax support when entering new file type buffer
    ensure_installed = {
      'lua',
      'python',
      -- 'javascript',
      'typescript',
      'html',
      'css',
      'json',
      'yaml',
      'bash',
      'markdown',
      'markdown_inline',
      'vim',
      'gitcommit',
      'git_rebase',
      'diff',
      'git_config',
      -- 'gitcommit',
      'gitignore',
      'gitattributes',
      'ninja',
      'rst',
    },
  },
  config = function(_, opts)
    local configs = require("nvim-treesitter.configs")
    configs.setup(opts)
  end
}
