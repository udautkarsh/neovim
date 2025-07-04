-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- General keymaps
keymap.set("n", "<leader>wq", ":wq<CR>")       -- save and quit
keymap.set("n", "<leader>qq", ":q!<CR>")       -- quit without saving
keymap.set("n", "<leader>ww", ":w<CR>")        -- save
keymap.set("n", "gx", ":!open <c-r><c-a><CR>") -- open URL under cursor


-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v")     -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s")     -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=")     -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window
keymap.set("n", "<leader>sj", "<C-w>-")     -- make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+")     -- make split windows height taller
keymap.set("n", "<leader>sl", "<C-w>>5")    -- make split windows width bigger
keymap.set("n", "<leader>ss", "<C-w><5")    -- make split windows width smaller

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>")   -- open a new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close a tab
keymap.set("n", "<leader>tn", ":tabn<CR>")     -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>")     -- previous tab

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>")   -- put diff from current to other during diff
keymap.set("n", "<leader>cj", ":diffget 1<CR>") -- get diff from left (local) during merge
keymap.set("n", "<leader>ck", ":diffget 3<CR>") -- get diff from right (remote) during merge
keymap.set("n", "<leader>cn", "]c")             -- next diff hunk
keymap.set("n", "<leader>cp", "[c")             -- previous diff hunk

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>")  -- open quickfix list
keymap.set("n", "<leader>qf", ":cfirst<CR>") -- jump to first quickfix list item
keymap.set("n", "<leader>qn", ":cnext<CR>")  -- jump to next quickfix list item
keymap.set("n", "<leader>qp", ":cprev<CR>")  -- jump to prev quickfix list item
keymap.set("n", "<leader>ql", ":clast<CR>")  -- jump to last quickfix list item
keymap.set("n", "<leader>qc", ":cclose<CR>") -- close quickfix list

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle maximize tab



-- Nvim-tree
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>")   -- toggle file explorer
keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>")    -- toggle focus to file explorer
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>") -- find file in file explorer
-- uday
keymap.set("n", "<leader>nn", ":NvimTreeFindFile<CR>") -- Alternative mouse toggle using Ctrl + n
keymap.set("n", "<leader>nn", ":NvimTreeToggle<CR>")
keymap.set("n", "<leader>et", "<C-w>l")                -- Move focus to editor
keymap.set("n", "<leader>ef", "<C-w>h")                -- Move focus to NvimTree
keymap.set("n", "<C-Left>", "<C-w>h")                  -- Move left to NvimTree
keymap.set("n", "<C-Right>", "<C-w>l")                 -- Move right to file editor
keymap.set("n", "<C-Up>", "<C-w>k")                    -- Move up to NvimTree
keymap.set("n", "<C-Down>", "<C-w>j")                  -- Move down to file editor
-- toggle hidden files in nvim tree
vim.keymap.set("n", "<leader>.", function()
  local api = require("nvim-tree.api")
  api.tree.toggle_hidden_filter()
end, { desc = "Toggle hidden files in NvimTree" })




--[[
-- neotree
-- Toggle the neo-tree explorer
vim.keymap.set("n", "<leader>ee", ":Neotree toggle<CR>", { desc = "Toggle NeoTree explorer" })

-- Move focus to the neo-tree explorer
vim.keymap.set("n", "<leader>er", ":Neotree focus<CR>", { desc = "Focus NeoTree explorer" })

-- Reveal current file in the neo-tree explorer (find file)
vim.keymap.set("n", "<leader>ef", ":Neotree reveal<CR>", { desc = "Reveal file in NeoTree" })

-- Alternative toggle/find mapping (as provided)
vim.keymap.set("n", "<leader>nn", ":Neotree toggle<CR>", { desc = "Alternative toggle for NeoTree" })

-- toggle hidden files
-- shift + h


-- Window navigation: these can remain as they are, assuming your neo-tree window is on the left.
vim.keymap.set("n", "<leader>et", "<C-w>l", { desc = "Move focus to editor" })
-- If you need to move focus to neo-tree from the editor, use the focus command (or adjust as desired).
-- Here, we keep the original left/right/up/down mappings:
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Move left (to NeoTree)" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Move right (to editor)" })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Move up" })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Move down" })
--]]




-- Telescope
keymap.set('n', '<leader><leader>', require('telescope.builtin').find_files, {})                                        -- fuzzy find files in project
keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})                                               -- grep file contents in project
keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})                                                 -- fuzzy find open buffers
keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})                                               -- fuzzy find help tags
keymap.set('n', '<leader>fs', require('telescope.builtin').current_buffer_fuzzy_find, {})                               -- fuzzy find in current file buffer
keymap.set('n', '<leader>fo', require('telescope.builtin').lsp_document_symbols, {})                                    -- fuzzy find LSP/class symbols
keymap.set('n', '<leader>fi', require('telescope.builtin').lsp_incoming_calls, {})                                      -- fuzzy find LSP/incoming calls
-- keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({default_text=":method:"}) end) -- fuzzy find methods in current class
keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({ symbols = { 'function', 'method' } }) end) -- fuzzy find methods in current class
keymap.set('n', '<leader>ft', function()                                                                                -- grep file contents in current nvim-tree node
  local success, node = pcall(function() return require('nvim-tree.lib').get_node_at_cursor() end)
  if not success or not node then return end;
  require('telescope.builtin').live_grep({ search_dirs = { node.absolute_path } })
end)
-- Telescope Git pickers
keymap.set('n', '<leader>tg', require('telescope.builtin').git_status, { desc = "Telescope: Git status" })
keymap.set('n', '<leader>tb', require('telescope.builtin').git_branches, { desc = "Telescope: Git branches" })
keymap.set('n', '<leader>tc', require('telescope.builtin').git_commits, { desc = "Telescope: Git commits" })
keymap.set('n', '<leader>tC', require('telescope.builtin').git_bcommits, { desc = "Telescope: Buffer commits" })
keymap.set('n', '<leader>ts', require('telescope.builtin').git_stash, { desc = "Telescope: Git stash" })


-- Harpoon
keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu)
keymap.set("n", "<leader>h1", function() require("harpoon.ui").nav_file(1) end)
keymap.set("n", "<leader>h2", function() require("harpoon.ui").nav_file(2) end)
keymap.set("n", "<leader>h3", function() require("harpoon.ui").nav_file(3) end)
keymap.set("n", "<leader>h4", function() require("harpoon.ui").nav_file(4) end)
keymap.set("n", "<leader>h5", function() require("harpoon.ui").nav_file(5) end)
keymap.set("n", "<leader>h6", function() require("harpoon.ui").nav_file(6) end)
keymap.set("n", "<leader>h7", function() require("harpoon.ui").nav_file(7) end)
keymap.set("n", "<leader>h8", function() require("harpoon.ui").nav_file(8) end)
keymap.set("n", "<leader>h9", function() require("harpoon.ui").nav_file(9) end)

-- Vim REST Console
keymap.set("n", "<leader>xr", ":call VrcQuery()<CR>") -- Run REST query

-- LSP
keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show hover documentation" })

keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
keymap.set('n', 'gb', '<C-o>', { desc = 'Go back in jump list' })
-- alterntive
keymap.set('n', '<C-CR>', vim.lsp.buf.definition, { desc = "Go to definition" })
keymap.set('n', '<C-BS>', '<C-o>', { desc = 'Go back in jump list' })

keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = "Go to type definition" })
keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Go to references" })
keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = "Show signature help" })
keymap.set('n', 'rr', vim.lsp.buf.rename, { desc = "Rename symbol" }) -- or use <leader>rn
keymap.set('n', 'gf', function() vim.lsp.buf.format { async = true } end, { desc = "Format buffer" })
keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = "Code action" })
keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Show diagnostics" })
keymap.set('n', 'gp', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap.set('n', 'gn', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap.set('n', 'tr', vim.lsp.buf.document_symbol, { desc = "Document symbols" })
keymap.set('i', '<C-Space>', vim.lsp.buf.completion, { desc = "LSP completion" })

-- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)
--[[
keymap.set("n", '<leader>tc', function()
  if vim.bo.filetype == 'python' then
    require('dap-python').test_class();
  end
end)

keymap.set("n", '<leader>tm', function()
  if vim.bo.filetype == 'python' then
    require('dap-python').test_method();
  end
end)
--]]


-- gitsigns
keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})              -- preview git hunk
keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {}) -- toggle current line blame


-- vim-figitive
keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Open Git status" }) -- open git status
keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "Open Git log" }) -- open git log
keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Open Git commit" }) -- open git commit
keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" }) -- push changes
keymap.set("n", "<leader>gf", ":Git fetch<CR>", { desc = "Git fetch" }) -- fetch changes
keymap.set("n", "<leader>gP", ":Git pull<CR>", { desc = "Git pull" }) -- pull changes
keymap.set("n", "<leader>gd", ":Git diff<CR>", { desc = "Git diff" }) -- show git diff
keymap.set("n", "<leader>gD", ":Git difftool<CR>", { desc = "Git difftool" }) -- show git diff in difftool
keymap.set("n", "<leader>gB", ":Git blame<CR>", { desc = "Git blame" }) -- show git blame
keymap.set("n", "<leader>gS", ":Git stash<CR>", { desc = "Git stash" }) -- stash changes
keymap.set("n", "<leader>gA", ":Git add .<CR>", { desc = "Git add all changes" }) -- add all changes
keymap.set("n", "<leader>gR", ":Git reset HEAD<CR>", { desc = "Git reset HEAD" }) -- reset HEAD
keymap.set("n", "<leader>gC", ":Git checkout<CR>", { desc = "Git checkout" }) -- checkout branch
keymap.set("n", "<leader>gM", ":Git merge<CR>", { desc = "Git merge" }) -- merge branch
keymap.set("n", "<leader>gL", ":Git log --oneline<CR>", { desc = "Git log oneline" }) -- show git log in one line
keymap.set("n", "<leader>gO", ":Git log --oneline --graph<CR>", { desc = "Git log oneline graph" }) -- show git log in one line with graph


-- noice.nvim
keymap.set("n", "<leader>nm", ":Noice<CR>", { desc = "Toggle Noice" })                   -- toggle Noice UI
keymap.set("n", "<leader>nd", ":NoiceDismiss<CR>", { desc = "Dismiss notice messages" }) -- Dismiss  message

-- Spell checking
keymap.set("n", "<leader>sc", ":set spell!<CR>", { desc = "Toggle Spell Checking" }) -- toggle spell checking


-- Copilotchat keymap
keymap.set("n", "<leader>zc", ":CopilotChat<CR>", { desc = "Chat with copilot" })
keymap.set("n", "<leader>ze", ":CopilotChatExplain<CR>", { desc = "Explain code" })
keymap.set("n", "<leader>zi", ":CopilotChatInfo<CR>", { desc = "Show copilot info" })
keymap.set("n", "<leader>zq", ":CopilotChatQuickPick<CR>", { desc = "Quick pick copilot suggestions" })
keymap.set("n", "<leader>zr", ":CopilotChatRefresh<CR>", { desc = "Refresh copilot suggestions" })
keymap.set("n", "<leader>zs", ":CopilotChatSuggest<CR>", { desc = "Suggest code with copilot" })
keymap.set("n", "<leader>zt", ":CopilotChatToggle<CR>", { desc = "Toggle copilot chat" })
keymap.set("n", "<leader>zv", ":CopilotChatView<CR>", { desc = "View copilot chat" })
keymap.set("n", "<leader>zx", ":CopilotChatDismiss<CR>", { desc = "Dismiss copilot chat" })
keymap.set("n", "<leader>zy", ":CopilotChatCopy<CR>", { desc = "Copy copilot chat" })
keymap.set("n", "<leader>zj", ":CopilotChatJump<CR>", { desc = "Jump to copilot chat" })
keymap.set("n", "<leader>zk", ":CopilotChatClose<CR>", { desc = "Close copilot chat" })
keymap.set("n", "<leader>zl", ":CopilotChatList<CR>", { desc = "List copilot chats" })
keymap.set("n", "<leader>zm", ":CopilotChatMerge<CR>", { desc = "Merge copilot chat suggestions" })
keymap.set("n", "<leader>zn", ":CopilotChatNew<CR>", { desc = "Start a new copilot chat" })
keymap.set("n", "<leader>zo", ":CopilotChatOpen<CR>", { desc = "Open copilot chat" })
keymap.set("n", "<leader>zp", ":CopilotChatPaste<CR>", { desc = "Paste copilot chat suggestion" })
keymap.set("n", "<leader>zd", ":CopilotChatDocs<CR>", { desc = "Document copilot chat" })



-- Copilot keymaps

keymap.set("i", "<Tab>", function()
  require("copilot.suggestion").accept()
end, { desc = "Copilot Accept Suggestion" })

keymap.set("i", "<Esc>", function()
  require("copilot.suggestion").dismiss()
  return "<Esc>"
end, { desc = "Copilot Dismiss Suggestion", expr = true })

keymap.set("i", "<M-]>", function()
  require("copilot.suggestion").next()
end, { desc = "Copilot Next Suggestion" })

keymap.set("i", "<M-[>", function()
  require("copilot.suggestion").prev()
end, { desc = "Copilot Previous Suggestion" })




-- Neovim's spell
-- Use ]s and [s to jump to next/previous misspelled word.
-- Use z= to see suggestions and choose a correction.

-- Debugging (DAP)
local dap = require("dap")
local dapui = require("dapui")
local opts = { noremap = true, silent = true }

-- Toggle breakpoint
keymap.set("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, opts)

-- Continue / Start
keymap.set("n", "<leader>dc", function()
  dap.continue()
  require("nvim-tree.api").tree.close()
end, opts)

-- Step Over
keymap.set("n", "<leader>do", function()
  dap.step_over()
end, opts)

-- Step Into
keymap.set("n", "<leader>di", function()
  dap.step_into()
end, opts)

-- Step Out
keymap.set("n", "<leader>dO", function()
  dap.step_out()
end, opts)

-- Keymap to terminate debugging
keymap.set("n", "<leader>dt", function()
  dap.terminate()
  dapui.close()
  require("nvim-tree.api").tree.close()
  require("nvim-tree.api").tree.open()
end, opts)

-- Toggle DAP UI
keymap.set("n", "<leader>du", function()
  dapui.toggle()
end, opts)


-- Diagnostic keymaps
keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap.set('n', '<leader>dm', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })



