-- Keymaps configuration
-- Leader key is set to space in remap.lua

local M = {}

-- Function to set keymaps with which-key integration
function M.setup()
  -- Basic keymaps
  vim.keymap.set("n", "<leader>pv", ":Oil<CR>", { desc = "Open Oil file explorer" })
  
  -- System clipboard integration
  vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
  vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
  
  -- Diagnostic keymaps
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic error messages' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
  
  -- Clear search highlight
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
  
  -- Better window navigation
  vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Navigate to left window' })
  vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Navigate to window below' })
  vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Navigate to window above' })
  vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Navigate to right window' })
  
  -- Resize windows with arrows
  vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
  vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
  vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
  vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })
  
  -- Buffer navigation
  vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
  vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })
  
  -- Stay in indent mode
  vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
  vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })
  
  -- Move text up and down
  vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected text down' })
  vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected text up' })
  
  -- Better paste
  vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste without yanking replaced text' })
  
  -- Quick save
  vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
  
  -- Quick quit
  vim.keymap.set('n', '<leader>Q', ':qa!<CR>', { desc = 'Quit all without saving' })
  
  -- Split windows
  vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
  vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
  vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' })
  vim.keymap.set('n', '<leader>sx', ':close<CR>', { desc = 'Close current split' })
  
  -- Snacks.nvim terminal integration
  vim.keymap.set('n', '<leader>tt', function() Snacks.terminal() end, { desc = 'Open Terminal' })
  vim.keymap.set('n', '<leader>tg', function() Snacks.lazygit() end, { desc = 'Open LazyGit' })
  
  -- Focus and zen mode
  vim.keymap.set('n', '<leader>z', function() Snacks.zen() end, { desc = 'Toggle Zen Mode' })
  vim.keymap.set('n', '<leader>Z', function() Snacks.zen.zoom() end, { desc = 'Zoom Current Window' })
  
  -- Scratch buffer
  vim.keymap.set('n', '<leader>S', function() Snacks.scratch() end, { desc = 'Open Scratch Buffer' })
  vim.keymap.set('n', '<leader>Ss', function() Snacks.scratch.select() end, { desc = 'Select Scratch Buffer' })
  
  -- Toggle utilities
  vim.keymap.set('n', '<leader>td', function() Snacks.toggle.dim() end, { desc = 'Toggle Dim Inactive Windows' })
  vim.keymap.set('n', '<leader>ti', function() Snacks.toggle.inlay_hints() end, { desc = 'Toggle Inlay Hints' })
  vim.keymap.set('n', '<leader>tI', function() Snacks.toggle.indent() end, { desc = 'Toggle Indent Guides' })
  vim.keymap.set('n', '<leader>tw', function() Snacks.toggle.words() end, { desc = 'Toggle Word Highlights' })
  
  -- Enhanced notifications
  vim.keymap.set('n', '<leader>nh', function() Snacks.notifier.show_history() end, { desc = 'Show Notification History' })
  vim.keymap.set('n', '<leader>nd', function() Snacks.notifier.hide() end, { desc = 'Dismiss Notifications' })
  
  -- Development utilities
  vim.keymap.set('n', '<leader>gb', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })
  vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete Buffer (Smart)' })
  
  -- Snacks.picker (gradual migration from telescope)
  -- Primary pickers - faster alternatives to telescope
  vim.keymap.set('n', '<leader>sf', function() Snacks.picker.files() end, { desc = '[S]earch [F]iles (Snacks)' })
  vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = '[S]earch by [G]rep (Snacks)' })
  vim.keymap.set('n', '<leader>sb', function() Snacks.picker.buffers() end, { desc = '[S]earch [B]uffers (Snacks)' })
  vim.keymap.set('n', '<leader>sr', function() Snacks.picker.resume() end, { desc = '[S]earch [R]esume (Snacks)' })
  vim.keymap.set('n', '<leader>sw', function() Snacks.picker.grep_word() end, { desc = '[S]earch current [W]ord (Snacks)' })
  
  -- Git pickers
  vim.keymap.set('n', '<leader>gf', function() Snacks.picker.git_files() end, { desc = '[G]it [F]iles (Snacks)' })
  vim.keymap.set('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = '[G]it [S]tatus (Snacks)' })
  vim.keymap.set('n', '<leader>gc', function() Snacks.picker.git_log() end, { desc = '[G]it [C]ommits (Snacks)' })
  
  -- LSP pickers
  vim.keymap.set('n', '<leader>ld', function() Snacks.picker.diagnostics() end, { desc = '[L]SP [D]iagnostics (Snacks)' })
  vim.keymap.set('n', '<leader>ls', function() Snacks.picker.lsp_symbols() end, { desc = '[L]SP [S]ymbols (Snacks)' })
  vim.keymap.set('n', '<leader>lr', function() Snacks.picker.lsp_references() end, { desc = '[L]SP [R]eferences (Snacks)' })
  
  -- Utility pickers
  vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = '[S]earch [K]eymaps (Snacks)' })
  vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end, { desc = '[S]earch [H]elp (Snacks)' })
  vim.keymap.set('n', '<leader>sc', function() Snacks.picker.command_history() end, { desc = '[S]earch [C]ommand History (Snacks)' })
  
  -- Quick alternative mappings (can replace telescope eventually)
  vim.keymap.set('n', '<C-p>', function() Snacks.picker.files() end, { desc = 'Quick File Search (Snacks)' })
  vim.keymap.set('n', '<leader>/', function() Snacks.picker.grep() end, { desc = 'Quick Grep Search (Snacks)' })
end

-- LSP keymaps (will be called from LspAttach autocmd)
function M.lsp_keymaps(bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end
  
  -- Navigation
  map('n', 'gd', vim.lsp.buf.definition, 'Goto definition')
  map('n', 'gD', vim.lsp.buf.declaration, 'Goto declaration')
  map('n', 'gr', vim.lsp.buf.references, 'Goto references')
  map('n', 'gI', vim.lsp.buf.implementation, 'Goto implementation')
  map('n', '<leader>D', vim.lsp.buf.type_definition, 'Type definition')
  map('n', '<leader>ds', vim.lsp.buf.document_symbol, 'Document symbols')
  map('n', '<leader>ws', vim.lsp.buf.workspace_symbol, 'Workspace symbols')
  
  -- Hover and signature help
  map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
  map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  map('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  
  -- Actions
  map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
  map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename')
  map('n', '<leader>f', vim.lsp.buf.format, 'Format')
  
  -- Inlay hints toggle (modern Neovim 0.10+)
  map('n', '<leader>h', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, 'Toggle inlay hints')
  
  -- Workspace
  map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace add folder')
  map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace remove folder')
  map('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'Workspace list folders')
end

return M