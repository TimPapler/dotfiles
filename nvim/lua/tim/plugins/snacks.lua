return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Core performance modules
    bigfile = { 
      enabled = true,
      size = 1.5 * 1024 * 1024, -- 1.5MB threshold
    },
    quickfile = { enabled = true },
    
    -- UI and visual enhancements
    dashboard = { 
      enabled = true,
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      }
    },
    statuscolumn = { enabled = true },
    indent = { enabled = true },
    image = { enabled = true },
    
    -- Enhanced notifications (replaces fidget.nvim)
    notifier = { 
      enabled = true,
      timeout = 3000,
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      style = "compact",
    },
    
    -- Fuzzy finder and navigation
    picker = { enabled = true },
    scope = { enabled = true },
    words = { enabled = true },
    
    -- Terminal and git integration
    terminal = { 
      enabled = true,
      win = {
        style = "terminal",
        height = 0.4,
        width = 0.8,
      }
    },
    lazygit = { 
      enabled = true,
      configure = true,
    },
    
    -- Focus and productivity features
    zen = { 
      enabled = true,
      toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
        diagnostics = false,
        inlay_hints = false,
      },
      win = { backdrop = 0.95 },
    },
    dim = { 
      enabled = true,
      scope = {
        min_size = 5,
        max_size = 20,
        siblings = true,
      }
    },
    
    -- Convenience features
    toggle = { enabled = true },
    scratch = { 
      enabled = true,
      win = {
        width = 100,
        height = 30,
        bo = { filetype = "text" },
      }
    },
    
    -- Smooth interactions
    animate = { 
      enabled = true,
      duration = { step = 15, total = 250 },
    },
    scroll = { 
      enabled = true,
      animate = {
        duration = { step = 15, total = 250 },
      }
    },
    
    -- Input enhancements
    input = { enabled = true },
    
    -- Development and productivity utilities
    profiler = { enabled = true },
    gitbrowse = { enabled = true },
    debug = { enabled = true },
    bufdelete = { enabled = true },
    
    -- Advanced window management
    layout = { enabled = true },
    win = { enabled = true },
    
    -- File explorer (keeping disabled for now, using oil.nvim)
    explorer = { enabled = false },
  },
}
