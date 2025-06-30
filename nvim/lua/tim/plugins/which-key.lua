return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    notify = false,
    triggers = {
      { "<auto>", mode = "nixsotc" },
      { "<leader>", mode = { "n", "v" } },
    },
    spec = {
      -- Root level groups
      { "<leader>a", group = "ai/claude" },
      { "<leader>c", group = "code" },
      { "<leader>f", group = "file/find" },
      { "<leader>p", group = "project" },
      { "<leader>s", group = "search" },
      { "<leader>w", group = "window/workspace" },
      { "<leader>r", group = "refactor" },
      { "<leader>d", group = "debug/diagnostics" },
      { "<leader>dg", group = "debug go" },
      { "<leader>t", group = "toggle" },
      { "<leader>g", group = "git" },
      
      -- Navigation groups
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "gc", group = "comment" },
      { "gb", group = "block comment" },
      { "z", group = "fold" },
      
      -- LSP groups (will be populated dynamically)
      { "<leader>ca", desc = "Code action" },
      { "<leader>rn", desc = "Rename" },
      { "<leader>f", desc = "Format" },
      { "<leader>D", desc = "Type definition" },
      { "<leader>ds", desc = "Document symbols" },
      { "<leader>ws", desc = "Workspace symbols" },
      { "<leader>wa", desc = "Workspace add folder" },
      { "<leader>wr", desc = "Workspace remove folder" },
      { "<leader>wl", desc = "Workspace list folders" },
      
      -- Claude Code operations
      { "<leader>ac", desc = "Toggle Claude Code terminal" },
      
      -- File operations
      { "<leader>pv", desc = "Open Oil file explorer" },
      
      -- System clipboard
      { "<leader>y", desc = "Yank to system clipboard", mode = { "n", "v" } },
      { "<leader>Y", desc = "Yank line to system clipboard" },
      
      -- Diagnostics
      { "<leader>e", desc = "Show diagnostic error messages" },
      { "<leader>q", desc = "Open diagnostic quickfix list" },
      { "[d", desc = "Go to previous diagnostic message" },
      { "]d", desc = "Go to next diagnostic message" },
      
      -- Comment operations
      { "gcc", desc = "Toggle line comment" },
      { "gbc", desc = "Toggle block comment" },
      { "gco", desc = "Add comment below and enter insert" },
      { "gcO", desc = "Add comment above and enter insert" },
      { "gcA", desc = "Add comment at end of line and enter insert" },
      { "gc", desc = "Toggle comment (with motion)", mode = { "n", "v" } },
      { "gb", desc = "Toggle block comment (with motion)", mode = { "n", "v" } },
      
      -- Search with Snacks.picker (primary)
      { "<leader>sf", desc = "Search files (Snacks)" },
      { "<leader>sg", desc = "Search by grep (Snacks)" },
      { "<leader>sb", desc = "Search buffers (Snacks)" },
      { "<leader>sr", desc = "Search resume (Snacks)" },
      { "<leader>sw", desc = "Search current word (Snacks)" },
      { "<leader>sk", desc = "Search keymaps (Snacks)" },
      { "<leader>sh", desc = "Search help (Snacks)" },
      { "<leader>sc", desc = "Search command history (Snacks)" },
      { "<C-p>", desc = "Quick file search (Snacks)" },
      { "<leader>/", desc = "Quick grep search (Snacks)" },
      
      -- Git operations (Snacks.picker)
      { "<leader>gf", desc = "Git files (Snacks)" },
      { "<leader>gs", desc = "Git status (Snacks)" },
      { "<leader>gc", desc = "Git commits (Snacks)" },
      
      -- LSP operations (Snacks.picker)
      { "<leader>ld", desc = "LSP diagnostics (Snacks)" },
      { "<leader>ls", desc = "LSP symbols (Snacks)" },
      { "<leader>lr", desc = "LSP references (Snacks)" },
      
      -- Session management
      { "<leader>q", group = "session" },
      { "<leader>qs", desc = "Restore session" },
      { "<leader>qS", desc = "Select session" },
      { "<leader>ql", desc = "Restore last session" },
      { "<leader>qd", desc = "Don't save session" },
      
      -- Snacks utilities
      { "<leader>S", desc = "Open scratch buffer" },
      { "<leader>Ss", desc = "Select scratch buffer" },
      { "<leader>z", desc = "Toggle zen mode" },
      { "<leader>Z", desc = "Zoom current window" },
      { "<leader>tt", desc = "Open terminal" },
      { "<leader>tg", desc = "Open LazyGit" },
      { "<leader>nh", desc = "Show notification history" },
      { "<leader>nd", desc = "Dismiss notifications" },
      
      -- Telescope legacy
      { "<leader>T", group = "telescope (legacy)" },
      { "<leader>Ts", desc = "Telescope select" },
      { "<leader>Tn", desc = "Telescope Neovim files" },
      { "<leader>T/", desc = "Telescope current buffer fuzzy" },
      { "<leader>T?", desc = "Telescope search open files" },
      
      -- Window management
      { "<leader>sv", desc = "Split window vertically" },
      { "<leader>sh", desc = "Split window horizontally" },
      { "<leader>se", desc = "Make splits equal size" },
      { "<leader>sx", desc = "Close current split" },
      { "<leader>w", desc = "Save file" },
      { "<leader>Q", desc = "Quit all without saving" },
      
      -- Buffer navigation
      { "<S-l>", desc = "Next buffer" },
      { "<S-h>", desc = "Previous buffer" },
      
      -- Visual mode
      { "<", desc = "Indent left and reselect", mode = "v" },
      { ">", desc = "Indent right and reselect", mode = "v" },
      { "J", desc = "Move selected text down", mode = "v" },
      { "K", desc = "Move selected text up", mode = "v" },
      { "p", desc = "Paste without yanking replaced text", mode = "v" },
      
      -- Window resizing
      { "<C-Up>", desc = "Increase window height" },
      { "<C-Down>", desc = "Decrease window height" },
      { "<C-Left>", desc = "Decrease window width" },
      { "<C-Right>", desc = "Increase window width" },
      
      -- Window navigation
      { "<C-h>", desc = "Navigate to left window" },
      { "<C-j>", desc = "Navigate to window below" },
      { "<C-k>", desc = "Navigate to window above" },
      { "<C-l>", desc = "Navigate to right window" },
      
      -- LSP navigation
      { "gd", desc = "Goto definition" },
      { "gD", desc = "Goto declaration" },
      { "gr", desc = "Goto references" },
      { "gI", desc = "Goto implementation" },
      { "K", desc = "Hover Documentation" },
      
      -- Clear search highlight
      { "<Esc>", desc = "Clear search highlight" },
      
      -- System integration
      { "gx", desc = "Open with system app" },
      
      -- Debug operations (General DAP)
      { "<leader>dc", desc = "Debug Continue" },
      { "<leader>ds", desc = "Debug Step Over" },
      { "<leader>di", desc = "Debug Step Into" },
      { "<leader>do", desc = "Debug Step Out" },
      { "<leader>dR", desc = "Open Debug REPL" },
      { "<leader>dl", desc = "Debug Run Last" },
      { "<leader>dq", desc = "Terminate Debug Session" },
      { "<leader>db", desc = "Toggle Breakpoint (DAP)" },
      { "<leader>dB", desc = "Set Conditional Breakpoint" },
      { "<leader>lp", desc = "Set Log Point" },
      
      -- Debug operations (Swift/iOS - Xcode)
      { "<leader>dd", desc = "Build & Debug (Xcode)" },
      { "<leader>dr", desc = "Debug Without Building (Xcode)" },
      { "<leader>dt", desc = "Debug Tests (Xcode)" },
      { "<leader>dT", desc = "Debug Class Tests (Xcode)" },
      { "<leader>dx", desc = "Terminate Debugger (Xcode)" },
      { "<leader>b", desc = "Toggle Breakpoint (Xcode)" },
      { "<leader>B", desc = "Toggle Message Breakpoint (Xcode)" },
      
      -- Debug operations (JavaScript/TypeScript)
      { "<leader>dj", desc = "Debug JS/TS File" },
      { "<leader>dJ", desc = "Debug Jest Tests" },
      
      -- Debug operations (Go)
      { "<leader>dgt", desc = "Debug Go Test" },
      { "<leader>dgl", desc = "Debug Last Go Test" },
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