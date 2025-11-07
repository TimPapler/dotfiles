return {
  "mfussenegger/nvim-dap-python",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    -- Setup dap-python with system python (or specify a path)
    -- You can also use a virtual environment:
    -- require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    require('dap-python').setup('python3')

    -- Python debugging keybindings
    vim.keymap.set('n', '<leader>dpm', function()
      require('dap-python').test_method()
    end, { desc = 'Debug Python Test Method' })
    
    vim.keymap.set('n', '<leader>dpc', function()
      require('dap-python').test_class()
    end, { desc = 'Debug Python Test Class' })
    
    vim.keymap.set('n', '<leader>dps', function()
      require('dap-python').debug_selection()
    end, { desc = 'Debug Python Selection' })
    
    -- Python file debugging (uses general DAP)
    vim.keymap.set('n', '<leader>dpf', function()
      local dap = require('dap')
      dap.run({
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        pythonPath = function()
          -- Check for virtual environment
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
            return cwd .. '/venv/bin/python'
          elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
            return cwd .. '/.venv/bin/python'
          else
            return '/usr/bin/python3'
          end
        end,
      })
    end, { desc = 'Debug Python File' })
  end,
}