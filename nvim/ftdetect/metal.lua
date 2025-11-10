-- autocommand that detects metal filetype
vim.filetype.add({
	extension = {
		metal = "metal"
	}
})

-- Use C++ Tree-sitter for syntax highlighting since Metal is based on C++
vim.api.nvim_create_autocmd("FileType", {
	pattern = "metal",
	callback = function()
		vim.treesitter.language.register("cpp", "metal")
	end,
})
