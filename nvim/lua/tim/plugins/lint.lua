return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      swift = { "swiftlint" },
    }

    -- Custom swiftlint configuration with correct arguments
    local default_swiftlint = require("lint.linters.swiftlint")
    if type(default_swiftlint) == "function" then
      default_swiftlint = default_swiftlint()
    end

    lint.linters.swiftlint = {
      cmd = "swiftlint",
      stdin = true,
      args = {
        "lint",
        "--use-stdin",
        "--reporter", "json",
      },
      ignore_exitcode = true,
      parser = default_swiftlint.parser,
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
      group = lint_augroup,
      callback = function()
        if not vim.endswith(vim.fn.bufname(), "swiftinterface") then
          require("lint").try_lint()
        end
      end,
    })

    vim.keymap.set("n", "<leader>ml", function()
      require("lint").try_lint()
    end, { desc = "Lint file" })
  end,
}
