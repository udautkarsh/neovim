-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- General keymaps
keymap.set("n", "<leader>wq", ":wq<CR>") -- save and quit
keymap.set("n", "<leader>qq", ":q!<CR>") -- quit without saving
keymap.set("n", "<leader>ww", ":w<CR>") -- save
keymap.set("n", "gx", ":!open <c-r><c-a><CR>") -- open URL under cursor


-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window
keymap.set("n", "<leader>sj", "<C-w>-") -- make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+") -- make split windows height taller
keymap.set("n", "<leader>sl", "<C-w>>5") -- make split windows width bigger 
keymap.set("n", "<leader>ss", "<C-w><5") -- make split windows width smaller

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open a new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close a tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- previous tab

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>") -- put diff from current to other during diff
keymap.set("n", "<leader>cj", ":diffget 1<CR>") -- get diff from left (local) during merge
keymap.set("n", "<leader>ck", ":diffget 3<CR>") -- get diff from right (remote) during merge
keymap.set("n", "<leader>cn", "]c") -- next diff hunk
keymap.set("n", "<leader>cp", "[c") -- previous diff hunk

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>") -- open quickfix list
keymap.set("n", "<leader>qf", ":cfirst<CR>") -- jump to first quickfix list item
keymap.set("n", "<leader>qn", ":cnext<CR>") -- jump to next quickfix list item
keymap.set("n", "<leader>qp", ":cprev<CR>") -- jump to prev quickfix list item
keymap.set("n", "<leader>ql", ":clast<CR>") -- jump to last quickfix list item
keymap.set("n", "<leader>qc", ":cclose<CR>") -- close quickfix list

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle maximize tab

-- Nvim-tree
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>") -- toggle file explorer
keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>") -- toggle focus to file explorer
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>") -- find file in file explorer
-- uday
keymap.set("n", "<leader>nn", ":NvimTreeFindFile<CR>") -- Alternative mouse toggle using Ctrl + n
keymap.set("n", "<leader>nn", ":NvimTreeToggle<CR>") 
keymap.set("n", "<leader>et", "<C-w>l") -- Move focus to editor
keymap.set("n", "<leader>ef", "<C-w>h") -- Move focus to NvimTree
keymap.set("n", "<C-Left>", "<C-w>h")  -- Move left to NvimTree
keymap.set("n", "<C-Right>", "<C-w>l") -- Move right to file editor
keymap.set("n", "<C-Up>", "<C-w>k")  -- Move up to NvimTree
keymap.set("n", "<C-Down>", "<C-w>j") -- Move down to file editor



-- Telescope
keymap.set('n', '<leader><leader>', require('telescope.builtin').find_files, {}) -- fuzzy find files in project
keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {}) -- grep file contents in project
keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {}) -- fuzzy find open buffers
keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {}) -- fuzzy find help tags
keymap.set('n', '<leader>fs', require('telescope.builtin').current_buffer_fuzzy_find, {}) -- fuzzy find in current file buffer
keymap.set('n', '<leader>fo', require('telescope.builtin').lsp_document_symbols, {}) -- fuzzy find LSP/class symbols
keymap.set('n', '<leader>fi', require('telescope.builtin').lsp_incoming_calls, {}) -- fuzzy find LSP/incoming calls
-- keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({default_text=":method:"}) end) -- fuzzy find methods in current class
keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({symbols={'function', 'method'}}) end) -- fuzzy find methods in current class
keymap.set('n', '<leader>ft', function() -- grep file contents in current nvim-tree node
  local success, node = pcall(function() return require('nvim-tree.lib').get_node_at_cursor() end)
  if not success or not node then return end;
  require('telescope.builtin').live_grep({search_dirs = {node.absolute_path}})
end)


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
keymap.set('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>')
keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>')
keymap.set('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
keymap.set('v', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>')
keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>')

-- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)
keymap.set("n", '<leader>go', function()
  if vim.bo.filetype == 'python' then
    vim.api.nvim_command('PyrightOrganizeImports')
  end
end)

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


-- gitsigns
keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {}) -- preview git hunk
keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {}) -- toggle current line blame

-- noice.nvim
keymap.set("n", "<leader>nm", ":Noice<CR>", { desc = "Toggle Noice" }) -- toggle Noice UI
keymap.set("n", "<leader>nd", ":NoiceDismiss<CR>", { desc = "Dismiss notice messages" }) -- Dismiss  message

-- Spell checking
keymap.set("n", "<leader>sc", ":set spell!<CR>", { desc = "Toggle Spell Checking" }) -- toggle spell checking


-- Copilotchat keymap
keymap.set("n", "<leader>zc", ":CopilotChat<CR>", {desc = "Chat with copilot"})
keymap.set("n", "<leader>ze", ":CopilotChatExplain<CR>", {desc = "Explain code"})
keymap.set("n", "<leader>zi", ":CopilotChatInfo<CR>", {desc = "Show copilot info"})
keymap.set("n", "<leader>zq", ":CopilotChatQuickPick<CR>", {desc = "Quick pick copilot suggestions"})
keymap.set("n", "<leader>zr", ":CopilotChatRefresh<CR>", {desc = "Refresh copilot suggestions"})
keymap.set("n", "<leader>zs", ":CopilotChatSuggest<CR>", {desc = "Suggest code with copilot"})
keymap.set("n", "<leader>zt", ":CopilotChatToggle<CR>", {desc = "Toggle copilot chat"})
keymap.set("n", "<leader>zv", ":CopilotChatView<CR>", {desc = "View copilot chat"})
keymap.set("n", "<leader>zx", ":CopilotChatDismiss<CR>", {desc = "Dismiss copilot chat"})
keymap.set("n", "<leader>zy", ":CopilotChatCopy<CR>", {desc = "Copy copilot chat"})
keymap.set("n", "<leader>zj", ":CopilotChatJump<CR>", {desc = "Jump to copilot chat"})
keymap.set("n", "<leader>zk", ":CopilotChatClose<CR>", {desc = "Close copilot chat"})
keymap.set("n", "<leader>zl", ":CopilotChatList<CR>", {desc = "List copilot chats"})
keymap.set("n", "<leader>zm", ":CopilotChatMerge<CR>", {desc = "Merge copilot chat suggestions"})
keymap.set("n", "<leader>zn", ":CopilotChatNew<CR>", {desc = "Start a new copilot chat"})
keymap.set("n", "<leader>zo", ":CopilotChatOpen<CR>", {desc = "Open copilot chat"})
keymap.set("n", "<leader>zp", ":CopilotChatPaste<CR>", {desc = "Paste copilot chat suggestion"})
keymap.set("n", "<leader>zd", ":CopilotChatDocs<CR>", {desc = "Document copilot chat"})



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