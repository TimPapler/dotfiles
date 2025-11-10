return {
	filetypes = { "metal" },

	cmd = { "metal-lsp" },

	root_dir = function(bufnr, on_dir)
		-- Try to find a git repo or Package.swift first
		local root = vim.fs.root(bufnr, { ".git", "Package.swift" })
		if root then
			on_dir(root)
		else
			-- Fallback: use the directory containing the file
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			on_dir(vim.fs.dirname(bufname))
		end
	end,
}
