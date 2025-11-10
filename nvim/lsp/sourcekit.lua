return {
	cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },

	filetypes = { "swift", "objc", "objcpp", "c", "cpp" },

	root_markers = {
		"buildServer.json",
		".xcodeproj",
		".xcworkspace",
		"compile_commands.json",
		"Package.swift",
		".git",
	},

	on_init = function(client)
		-- HACK: to fix some issues with LSP
		-- more details: https://github.com/neovim/neovim/issues/19237#issuecomment-2237037154
		client.offset_encoding = "utf-8"
	end,

	settings = {
		sourcekit = {
			-- Enable indexing for better cross-module support
			["indexing.enabled"] = true,
			-- Try to improve module resolution
			["swift.index-while-building"] = true,
		},
	},
}
