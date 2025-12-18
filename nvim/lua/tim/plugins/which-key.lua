return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    notify = false,
    triggers = {
      { "<auto>", mode = "nxso" },
      { "<leader>", mode = { "n", "v" } },
    },
    spec = {
      -- Root level groups
      { "<leader>f", group = "file/find" },
      { "<leader>p", group = "project" },
      { "<leader>s", group = "search" },
      { "<leader>w", group = "window/workspace" },
      { "<leader>r", group = "refactor" },
      { "<leader>d", group = "debug/diagnostics" },
      { "<leader>dg", group = "debug go" },
      { "<leader>dp", group = "debug python" },
      { "<leader>t", group = "toggle" },
      { "<leader>g", group = "git" },
      { "<leader>gh", group = "git hunks" },
      { "<leader>gt", group = "git toggles" },
      
      -- Navigation groups
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "gc", group = "comment" },
      { "gb", group = "block comment" },
      { "z", group = "fold/view" },

      -- Standard Vim navigation
      { "gg", desc = "Go to first line" },
      { "G", desc = "Go to last line" },
      { "^", desc = "Go to first non-blank character" },
      { "$", desc = "Go to end of line" },
      { "0", desc = "Go to start of line" },
      { "w", desc = "Next word" },
      { "b", desc = "Previous word" },
      { "e", desc = "End of word" },
      { "{", desc = "Previous paragraph" },
      { "}", desc = "Next paragraph" },
      { "%", desc = "Jump to matching bracket" },
      { "*", desc = "Search word under cursor (forward)" },
      { "#", desc = "Search word under cursor (backward)" },
      { "n", desc = "Repeat search (forward)" },
      { "N", desc = "Repeat search (backward)" },

      -- Standard Vim marks and jumps
      { "m", group = "mark" },
      { "'", group = "goto mark (line)" },
      { "`", group = "goto mark (exact)" },
      { "''", desc = "Jump to last position" },
      { "<C-o>", desc = "Jump to older position" },
      { "<C-i>", desc = "Jump to newer position" },

      -- Standard Vim editing
      { "u", desc = "Undo" },
      { "<C-r>", desc = "Redo" },
      { ".", desc = "Repeat last change" },
      { "x", desc = "Delete character" },
      { "dd", desc = "Delete line" },
      { "yy", desc = "Yank (copy) line" },
      { "p", desc = "Paste after cursor" },
      { "P", desc = "Paste before cursor" },
      { ">>", desc = "Indent line" },
      { "<<", desc = "Unindent line" },

      -- Standard Vim modes
      { "v", desc = "Visual mode (character)" },
      { "V", desc = "Visual mode (line)" },
      { "<C-v>", desc = "Visual mode (block)" },

      -- Standard Vim view/fold
      { "zz", desc = "Center cursor on screen" },
      { "zt", desc = "Cursor to top of screen" },
      { "zb", desc = "Cursor to bottom of screen" },
      { "zo", desc = "Open fold" },
      { "zc", desc = "Close fold" },
      { "za", desc = "Toggle fold" },
      { "zR", desc = "Open all folds" },
      { "zM", desc = "Close all folds" },
      
      -- LSP, file operations, clipboard, and diagnostics auto-discovered from keymaps.lua
      
      -- Comment operations auto-discovered from Comment.nvim or keymaps

      -- Search with Snacks.picker - auto-discovered from keymaps.lua

      -- Git operations - auto-discovered from keymaps.lua and gitsigns plugin

      -- Git toggles auto-discovered from gitsigns
      { "<leader>gtb", desc = "Toggle git blame" },
      { "<leader>gth", desc = "Toggle git line highlight" },
      { "<leader>gtH", desc = "Toggle git deleted hunks" },
      
      -- LSP operations (Snacks.picker)
      { "<leader>l", group = "lsp" },
      { "<leader>ld", desc = "LSP diagnostics (Snacks)" },
      { "<leader>ls", desc = "LSP symbols (Snacks)" },
      { "<leader>lr", desc = "LSP references (Snacks)" },
      { "<leader>lR", desc = "Restart LSP" },
      
      -- Session management
      { "<leader>q", group = "session" },
      { "<leader>qs", desc = "Restore session" },
      { "<leader>qS", desc = "Select session" },
      { "<leader>ql", desc = "Restore last session" },
      { "<leader>qd", desc = "Don't save session" },
      
      -- Snacks utilities
      { "<leader>S", desc = "Open scratch buffer" },
      { "<leader>Ss", desc = "Select scratch buffer" },
      { "<leader>tt", desc = "Open terminal" },
      { "<leader>tg", desc = "Open LazyGit" },
      { "<leader>nh", desc = "Show notification history" },
      { "<leader>nd", desc = "Dismiss notifications" },
      { "<leader>gb", desc = "Git Browse (open in browser)" },
      { "<leader>bd", desc = "Delete Buffer (Smart)" },

      -- Toggle utilities
      { "<leader>td", desc = "Toggle Dim Inactive Windows" },
      { "<leader>ti", desc = "Toggle Inlay Hints" },
      { "<leader>tI", desc = "Toggle Indent Guides" },
      { "<leader>tw", desc = "Toggle Word Highlights" },
      
      -- Telescope legacy group removed as requested
      
      -- Window management
      { "<leader>sv", desc = "Split window vertically" },
      { "<leader>sh", desc = "Split window horizontally" },
      { "<leader>se", desc = "Make splits equal size" },
      { "<leader>sx", desc = "Close current split" },
      { "<leader>wm", desc = "Jump to main window" },
      { "<leader>wo", desc = "Close all but main window" },
      { "<leader>w", desc = "Save file" },
      { "<leader>Q", desc = "Quit all without saving" },
      
      -- Buffer navigation, visual mode enhancements, window operations, LSP navigation,
      -- and other keybindings auto-discovered from keymaps.lua
      
      -- Debug operations auto-discovered from plugin configs with 'desc' fields
      -- No manual entries needed - which-key finds them automatically!

      -- Xcodebuild operations auto-discovered from xcodebuild.lua

      -- Other operations auto-discovered from their respective plugin configs
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    {
      "<c-w><space>",
      function()
        require("which-key").show({ keys = "<c-w>", loop = true })
      end,
      desc = "Window Hydra Mode (which-key)",
    },
  },
}