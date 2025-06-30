return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signs_staged = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signs_staged_enable = true,
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
  },
  config = function(_, opts)
    require('gitsigns').setup(opts)
    
    -- Keybindings
    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { desc = 'Gitsigns: ' .. desc })
    end
    
    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        require('gitsigns').nav_hunk('next')
      end
    end, 'Next Hunk')
    
    map('n', '[h', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        require('gitsigns').nav_hunk('prev')
      end
    end, 'Prev Hunk')
    
    -- Actions (using <leader>gh for git hunks to avoid conflict with LSP inlay hints)
    map('n', '<leader>ghs', require('gitsigns').stage_hunk, 'Stage hunk')
    map('n', '<leader>ghr', require('gitsigns').reset_hunk, 'Reset hunk')
    map('v', '<leader>ghs', function() require('gitsigns').stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, 'Stage hunk (visual)')
    map('v', '<leader>ghr', function() require('gitsigns').reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, 'Reset hunk (visual)')
    map('n', '<leader>ghS', require('gitsigns').stage_buffer, 'Stage buffer')
    map('n', '<leader>ghu', require('gitsigns').undo_stage_hunk, 'Undo stage hunk')
    map('n', '<leader>ghR', require('gitsigns').reset_buffer, 'Reset buffer')
    map('n', '<leader>ghp', require('gitsigns').preview_hunk, 'Preview hunk')
    map('n', '<leader>ghb', function() require('gitsigns').blame_line{full=true} end, 'Blame line (full)')
    map('n', '<leader>ghd', require('gitsigns').diffthis, 'Diff this')
    map('n', '<leader>ghD', function() require('gitsigns').diffthis('~') end, 'Diff this (~)')
    
    -- Toggles (using git-specific prefix to avoid conflicts)
    map('n', '<leader>gtb', require('gitsigns').toggle_current_line_blame, 'Toggle git blame')
    map('n', '<leader>gth', require('gitsigns').toggle_linehl, 'Toggle git line highlight')
    map('n', '<leader>gtH', require('gitsigns').toggle_deleted, 'Toggle git deleted hunks')
    
    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns hunk')
  end,
}