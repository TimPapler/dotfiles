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
      keymaps = {
        ["<C-p>"] = false,  -- Disable Oil's preview, use global <C-p> for file search
        ["<C-h>"] = false,  -- Disable Oil's horizontal split, use global <C-h> for window nav
        ["<C-l>"] = false,  -- Disable Oil's refresh, use global <C-l> for window nav
        ["<C-s>"] = false,  -- Disable Oil's default splits
        ["<C-v>"] = false,  -- Disable Oil's default splits
        ["<leader>sv"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
        ["<leader>sh"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
        ["g."] = "actions.refresh",  -- Alternative refresh binding
      },
    })
  end
}
