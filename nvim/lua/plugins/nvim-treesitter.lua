-- File: plugins/treesitter.lua
return {
  'nvim-treesitter/nvim-treesitter',
  event = "BufReadPre",
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdateSync',
  opts = {
    -- 1. Store parsers in a cache directory you own
    parser_install_dir = vim.fn.stdpath("cache") .. "/treesitter-parsers",

    -- 2. Core features
    highlight    = { enable = true },
    indent       = { enable = true },
    auto_install = true,    -- we manage installs ourselves
    sync_install = true,    -- do installs asynchronously

    -- 3. Only these languages will ever be (auto)installed
    ensure_installed = {
      "lua",
      "python",
      "bash",
      "vim",
      "html",
      "css",
      "json",
      "yaml",
    },
  },
  config = function(_, opts)
    -- Prepend parser dir so installed grammars are recognized
    vim.opt.runtimepath:prepend(opts.parser_install_dir)

    -- Apply basic setup
    require("nvim-treesitter.configs").setup(opts)

    -- Auto-install missing parsers in the background
    local parsers   = require("nvim-treesitter.parsers")
    local to_install = {}
    for _, lang in ipairs(opts.ensure_installed) do
      if not parsers.has_parser(lang) then
        table.insert(to_install, lang)
      end
    end

    if #to_install > 0 then
      -- Defer so it doesn’t block startup
      vim.schedule(function()
        vim.cmd("TSInstall " .. table.concat(to_install, " "))
      end)
    end
  end,
}
