return {
  'nvim-treesitter/nvim-treesitter',
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "swift",
      "go",
      "javascript",
      "typescript",
      "c",
      "cpp",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "html",
      "css",
      "scss",
      "regex",
      "python",
      "bash",
      "json",
      "yaml",
      "latex",
      "svelte",
      "tsx",
      "typst",
      "vue",
    })

    -- Built-in treesitter highlighting for all filetypes with a parser
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })

    -- Built-in treesitter indentation
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
