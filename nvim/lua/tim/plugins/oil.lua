return {
  'stevearc/oil.nvim',
  -- Lazy load file explorer when needed
  cmd = { "Oil" },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open Oil file explorer" },
  },
  ---@module 'oil'
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      watch_for_changes = true,
      
      -- Floating window configuration
      float = {
        padding = 2,
        max_width = 90,
        max_height = 30,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
      
      keymaps = {
        ["<C-p>"] = false,  -- Disable Oil's preview, use global <C-p> for file search
        ["<C-h>"] = false,  -- Disable Oil's horizontal split, use global <C-h> for window nav
        ["<C-l>"] = false,  -- Disable Oil's refresh, use global <C-l> for window nav
        ["<C-s>"] = false,  -- Disable Oil's default splits
        ["<C-v>"] = false,  -- Disable Oil's default splits
        
        -- Default action: navigate folders, open files in current buffer
        ["<CR>"] = "actions.select",
        
        -- Non-conflicting split keymaps using 'g' prefix (mnemonic: "go to in split")
        ["gv"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
        ["gs"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
        ["gt"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
        
        -- Additional Oil-specific operations
        ["g."] = "actions.toggle_hidden",  -- Toggle hidden files (more useful than refresh)
        ["gr"] = "actions.refresh",  -- Refresh directory listing
        ["gp"] = "actions.preview",  -- Preview file under cursor
        ["gx"] = "actions.open_external",  -- Open file with system app
        
        -- Parent directory navigation (ergonomic alternatives)
        ["-"] = "actions.parent",  -- Go to parent directory (mirrors Oil trigger key)
        ["_"] = "actions.open_cwd",  -- Go to current working directory
      },
    })
  end
}
