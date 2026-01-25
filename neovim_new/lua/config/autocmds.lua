local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ============================================
-- PROJECT ROOT (capture initial path passed to nvim)
-- ============================================
-- Store the initial directory passed to nvim or cwd
vim.g.project_root = (function()
  local args = vim.fn.argv()
  if #args > 0 then
    local arg = args[1]
    -- If arg is a directory, use it
    if vim.fn.isdirectory(arg) == 1 then
      return vim.fn.fnamemodify(arg, ":p")
    end
    -- If arg is a file, use its parent directory
    return vim.fn.fnamemodify(arg, ":p:h")
  end
  -- Fallback to current working directory
  return vim.fn.getcwd()
end)()

-- ============================================
-- GENERAL AUTOCOMMANDS
-- ============================================
local general = augroup("General", { clear = true })

-- Highlight on yank
autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

-- Resize splits when window is resized
autocmd("VimResized", {
  group = general,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
  desc = "Resize splits on window resize",
})

-- Go to last location when opening a buffer
autocmd("BufReadPost", {
  group = general,
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go to last location when opening buffer",
})

-- Close some filetypes with <q>
autocmd("FileType", {
  group = general,
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns.blame",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
  desc = "Close with q",
})

-- Wrap and spell check in text files
autocmd("FileType", {
  group = general,
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  desc = "Wrap and spell check text files",
})

-- Fix conceallevel for json files
autocmd("FileType", {
  group = general,
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
  desc = "Fix conceallevel for JSON",
})

-- Auto create dir when saving file
autocmd("BufWritePre", {
  group = general,
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Auto create dir on save",
})

-- ============================================
-- TERMINAL AUTOCOMMANDS
-- ============================================
local terminal = augroup("Terminal", { clear = true })

-- Start terminal in insert mode
autocmd("TermOpen", {
  group = terminal,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
  desc = "Terminal settings",
})

-- ============================================
-- CURSOR LINE (only in active window)
-- ============================================
local cursorline = augroup("CursorLine", { clear = true })

autocmd({ "InsertLeave", "WinEnter" }, {
  group = cursorline,
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
  desc = "Show cursorline",
})

autocmd({ "InsertEnter", "WinLeave" }, {
  group = cursorline,
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
  desc = "Hide cursorline",
})

-- ============================================
-- CHECKTIME (auto reload files changed outside)
-- ============================================
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = general,
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
  desc = "Check for file changes",
})

-- ============================================
-- MAX BUFFER LIMIT
-- ============================================
local max_buffers = augroup("MaxBuffers", { clear = true })

-- Maximum number of open buffers (change this value as needed)
vim.g.max_open_buffers = 20  -- Increased from 5 to 20

autocmd("BufEnter", {
  group = max_buffers,
  callback = function()
    local max = vim.g.max_open_buffers or 5
    
    -- Get all listed buffers (real files, not special buffers)
    local buffers = vim.tbl_filter(function(buf)
      return vim.api.nvim_buf_is_valid(buf)
        and vim.bo[buf].buflisted
        and vim.bo[buf].buftype == ""
    end, vim.api.nvim_list_bufs())
    
    -- If we exceed the limit, close the oldest buffers
    if #buffers > max then
      -- Sort by last used (oldest first)
      table.sort(buffers, function(a, b)
        return vim.fn.getbufinfo(a)[1].lastused < vim.fn.getbufinfo(b)[1].lastused
      end)
      
      -- Close oldest buffers to get back to the limit
      local to_close = #buffers - max
      for i = 1, to_close do
        local buf = buffers[i]
        -- Don't close modified buffers
        if not vim.bo[buf].modified then
          vim.api.nvim_buf_delete(buf, { force = false })
        end
      end
    end
  end,
  desc = "Limit max open buffers",
})
