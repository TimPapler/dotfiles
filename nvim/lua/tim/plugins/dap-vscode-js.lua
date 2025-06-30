return {
  "mxsdev/nvim-dap-vscode-js",
  dependencies = {
    "mfussenegger/nvim-dap",
    {
      "microsoft/vscode-js-debug",
      build = "npm ci --legacy-peer-deps && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
      version = "1.*",
    },
  },
  config = function()
    local dap = require("dap")
    
    require("dap-vscode-js").setup({
      debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    })

    -- JavaScript/TypeScript configurations
    for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
      dap.configurations[language] = {
        -- Node.js debugging
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest Tests",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/.bin/jest",
            "--runInBand",
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
        -- Chrome debugging
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Chrome",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
        },
      }
    end

    -- Additional keybindings for JS/TS debugging
    vim.keymap.set("n", "<leader>dj", function()
      dap.run({
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
      })
    end, { desc = "Debug JS/TS File" })
    
    vim.keymap.set("n", "<leader>dJ", function()
      dap.run({
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/.bin/jest",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      })
    end, { desc = "Debug Jest Tests" })
  end,
}