return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  cmd = { "Claude", "ClaudeCode" },
  keys = {
    { "<leader>ac", ":ClaudeCode<CR>", desc = "Toggle Claude Code terminal" },
    { "<C-,>", ":ClaudeCode<CR>", desc = "Toggle Claude Code terminal" },
  },
  config = function()
    require("claude-code").setup(
      {
        command = "~/.claude/local/claude", -- Adjust this if your Claude binary is located elsewhere
      }
    )
  end
}
