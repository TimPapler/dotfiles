return {
	cmd = { "xcrun", "sourcekit-lsp" },

	filetypes = { "swift", "objc", "objcpp", "c", "cpp" },

	root_markers = {
		"buildServer.json",
		".xcodeproj",
		".xcworkspace",
		"compile_commands.json",
		"Package.swift",
		".git",
	},

	settings = {
		sourcekit = {
			["indexing.enabled"] = true,
			["swift.index-while-building"] = true,
		},
	},
}
