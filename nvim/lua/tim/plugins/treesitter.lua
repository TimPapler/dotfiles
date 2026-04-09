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

    -- Force full reparse for languages with buggy incremental parsing (e.g. Swift)
    local buggy_incremental = { swift = true }
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        if not buggy_incremental[args.match] then return end
        vim.api.nvim_create_autocmd("TextChanged", {
          buffer = args.buf,
          callback = function()
            local ok, parser = pcall(vim.treesitter.get_parser, args.buf)
            if ok and parser then
              parser:invalidate(true)
              parser:parse()
            end
          end,
        })
      end,
    })
  end,
}
