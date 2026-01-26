-- ============================================
-- LEADER KEY
-- ============================================
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- ============================================
-- LINE NUMBERS
-- ============================================
opt.number = true
opt.relativenumber = true

-- ============================================
-- TABS & INDENTATION
-- ============================================
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- ============================================
-- LINE WRAPPING
-- ============================================
opt.wrap = false
opt.linebreak = true
opt.breakindent = true

-- ============================================
-- SEARCH
-- ============================================
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "nosplit"

-- ============================================
-- APPEARANCE
-- ============================================
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.cursorline = true
opt.colorcolumn = "100"
opt.showmode = false
opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 10

-- ============================================
-- BEHAVIOR
-- ============================================
opt.backspace = "indent,eol,start"
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.virtualedit = "block"
opt.smoothscroll = true

-- ============================================
-- SPLITS
-- ============================================
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"

-- ============================================
-- WORD HANDLING
-- ============================================
opt.iskeyword:append("-")

-- ============================================
-- FILES & UNDO
-- ============================================
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undolevels = 10000
opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- ============================================
-- SCROLLING
-- ============================================
opt.scrolloff = 8
opt.sidescrolloff = 8

-- ============================================
-- TIMING
-- ============================================
opt.updatetime = 200
opt.timeoutlen = 300
-- Terminal key timeout (for Alt+Arrow keys)
opt.ttimeout = true
opt.ttimeoutlen = 500  -- Wait 500ms for terminal key sequences

-- ============================================
-- COMPLETION
-- ============================================
opt.completeopt = "menu,menuone,noselect"
opt.wildmode = "longest:full,full"

-- ============================================
-- FORMATTING
-- ============================================
opt.formatoptions = "jcroqlnt"

-- ============================================
-- GREP
-- ============================================
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- ============================================
-- FILL CHARS
-- ============================================
opt.fillchars = {
  eob = " ",
  diff = "╱",
}

-- ============================================
-- FOLDING
-- ============================================
opt.foldlevel = 99
opt.foldmethod = "indent"

-- ============================================
-- SESSION
-- ============================================
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- ============================================
-- MISC
-- ============================================
opt.confirm = true
opt.conceallevel = 2
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.spelllang = { "en" }
