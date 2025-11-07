-- Autocommands configuration

local M = {}

function M.setup()
  -- Highlight on yank
  local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = highlight_group,
    desc = 'Highlight when yanking text',
    callback = function()
      vim.highlight.on_yank({ timeout = 200 })
    end,
  })
  
  -- Close certain filetypes with q
  local close_with_q = vim.api.nvim_create_augroup('CloseWithQ', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    group = close_with_q,
    pattern = {
      'help',
      'lspinfo',
      'man',
      'notify',
      'qf',
      'query',
      'startuptime',
      'checkhealth',
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end,
  })
  
  -- Check if file changed outside of Neovim
  local checktime_group = vim.api.nvim_create_augroup('Checktime', { clear = true })
  vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = checktime_group,
    desc = 'Check if file changed when Neovim gains focus',
    command = 'checktime',
  })
  
  -- Resize splits if window got resized
  local resize_splits = vim.api.nvim_create_augroup('ResizeSplits', { clear = true })
  vim.api.nvim_create_autocmd('VimResized', {
    group = resize_splits,
    desc = 'Resize splits when terminal is resized',
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd('tabdo wincmd =')
      vim.cmd('tabn ' .. current_tab)
    end,
  })
  
  -- Go to last location when opening a buffer
  local last_location = vim.api.nvim_create_augroup('LastLocation', { clear = true })
  vim.api.nvim_create_autocmd('BufReadPost', {
    group = last_location,
    desc = 'Go to last location when opening a buffer',
    callback = function(event)
      local exclude = { 'gitcommit' }
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
  })
  
  -- Auto create directory when saving a file
  local auto_create_dir = vim.api.nvim_create_augroup('AutoCreateDir', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = auto_create_dir,
    desc = 'Auto create directory when saving a file',
    callback = function(event)
      if event.match:match('^%w%w+://') then
        return
      end
      local file = vim.uv.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
    end,
  })
  
  -- Wrap and check for spell in text filetypes
  local wrap_spell = vim.api.nvim_create_augroup('WrapSpell', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    group = wrap_spell,
    pattern = { 'gitcommit', 'markdown', 'text' },
    desc = 'Enable wrap and spell check for text files',
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })
  
  -- Fix conceallevel for json files
  local json_conceal = vim.api.nvim_create_augroup('JsonConceal', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    group = json_conceal,
    pattern = { 'json', 'jsonc', 'json5' },
    desc = 'Fix conceallevel for json files',
    callback = function()
      vim.opt_local.conceallevel = 0
    end,
  })
end

return M