return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>tq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Toggle Quickfix (Trouble)" } },
  },

  opts = {
    focus = false, -- Don't focus trouble when opened
    follow = false, -- Don't follow current item
    auto_close = false,
    auto_open = false,
    auto_jump = false,
    modes = {
      quickfix = {
        win = {
          size = { height = 10 },
        },
        format = "{severity_icon|item.type:DiagnosticError} {filename}:{pos} {text}",
      },
    },
  },
  config = function(_, opts)
    require("trouble").setup(opts)

    -- Prevent Trouble windows from being used to open normal files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "trouble",
      callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.wo.winfixbuf = true -- Lock buffer to this window
      end,
    })
  end,
}
