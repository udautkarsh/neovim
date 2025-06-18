local opt = vim.opt

-- Session Management
opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Line Numbers
opt.relativenumber = true
opt.number = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
vim.bo.softtabstop = 2

-- Line Wrapping
opt.wrap = false

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor Line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.showmode = false

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split Windows
opt.splitright = true
opt.splitbelow = true

-- Consider - as part of keyword
opt.iskeyword:append("-")

-- Disable the mouse while in nvim
opt.mouse = ""

-- Folding
opt.foldlevel = 20
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()" -- Utilize Treesitter folds

-- Enable spell check for all buffers by default
vim.opt.spell = false
vim.opt.spelllang = 'en_us'

-- Enable mouse support
opt.mouse = "a" -- Enable mouse support in all modes



-- vim diagnostic configurations


vim.diagnostic.config({
  float = { 
    border = "rounded",
    source = "always", -- Show source in diagnostic popup window
    header = "", -- Remove "Diagnostics" header
    prefix = "", -- Remove prefix from diagnostic message
  },
  virtual_text = {
    prefix = "●", -- Change the prefix for virtual text diagnostics
    spacing = 4,
    source = "always",
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
    format = function(diagnostic)
      return string.format("%s", diagnostic.message)
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E", -- Error sign
      [vim.diagnostic.severity.WARN] = "W",  -- Warning sign
      [vim.diagnostic.severity.INFO] = "I",  -- Info sign
      [vim.diagnostic.severity.HINT] = "H",  -- Hint sign
    }
  },
  severity_sort = true,
  update_in_insert = true,
  underline = true,
})

-- Remove trailing whitespace on save for yaml files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.yml", "*.yaml" },
  callback = function()
    -- Save cursor position
    local cursor = vim.fn.getpos(".")
    -- Remove trailing whitespace
    vim.cmd([[%s/\s\+$//e]])
    -- Restore cursor position
    vim.fn.setpos(".", cursor)
  end,
})

-- Set YAML indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "yaml.ansible" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})