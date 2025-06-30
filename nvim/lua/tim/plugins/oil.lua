return {
  'stevearc/oil.nvim',
  -- Lazy load file explorer when needed
  cmd = { "Oil" },
  keys = {
    { "<leader>pv", "<cmd>Oil<cr>", desc = "Open Oil file explorer" },
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
    })
  end
}
