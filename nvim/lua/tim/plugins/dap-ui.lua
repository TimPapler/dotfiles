return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  lazy = true,
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup({
      force_buffers = true,
      expand_lines = true,
      element_mappings = {},
      render = {
        indent = 1,  -- Minimal indentation (2 spaces per level)
        max_value_lines = 100,
        line_numbers = true,
        max_string_length = nil,  -- No limit on string display
        max_array_length = 100,
        max_children = 100,
      },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "",
          run_last = "",
          terminate = "⏹︎",
          pause = "⏸︎",
          play = "",
          step_into = "󰆹",
          step_out = "󰆸",
          step_over = "",
          step_back = "",
        },
      },
      floating = {
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      icons = {
        collapsed = "",
        expanded = "",
        current_frame = "",
      },
      layouts = {
        {
          -- Primary sidebar - focused on variable inspection
          elements = {
            { id = "scopes",  size = 0.5 },  -- Variables in current scope (most important)
            { id = "watches", size = 0.3 },  -- Watch expressions
            { id = "stacks",  size = 0.2 },  -- Call stack
          },
          position = "left",
          size = 50,  -- Wider for better readability
        },
        {
          -- Bottom panel - REPL only
          elements = {
            { id = "repl", size = 1.0 },  -- Debug REPL (also shows output)
          },
          position = "bottom",
          size = 12,
        },
        {
          -- Secondary sidebar (hidden by default, toggle with :lua require('dapui').open(3))
          elements = {
            { id = "breakpoints", size = 1.0 },
          },
          position = "right",
          size = 40,
        },
      },
    })

    local group = vim.api.nvim_create_augroup("dapui_config", { clear = true })

    -- hide ~ in DAPUI
    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = group,
      pattern = "DAP*",
      callback = function()
        vim.wo.fillchars = "eob: "
      end,
    })
    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = group,
      pattern = "\\[dap\\-repl\\]",
      callback = function()
        vim.wo.fillchars = "eob: "
      end,
    })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- DAP UI keymaps
    vim.keymap.set("n", "<leader>du", function()
      dapui.toggle()
    end, { desc = "Toggle DAP UI" })

    -- Hover evaluation - see variable value under cursor
    vim.keymap.set({ "n", "v" }, "<leader>dh", function()
      dapui.eval()
    end, { desc = "Evaluate Expression" })

    -- Evaluate expression in floating window (persistent)
    vim.keymap.set({ "n", "v" }, "<leader>de", function()
      dapui.eval(nil, { enter = true })
    end, { desc = "Evaluate in Floating Window" })

    -- Float scopes element (quick peek at variables without full UI)
    vim.keymap.set("n", "<leader>df", function()
      dapui.float_element("scopes", { enter = true })
    end, { desc = "Float Scopes" })

    -- Float stacks element (quick peek at call stack)
    vim.keymap.set("n", "<leader>dF", function()
      dapui.float_element("stacks", { enter = true })
    end, { desc = "Float Stacks" })
  end,
}
