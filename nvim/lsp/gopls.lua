return {
	filetypes = { "go", "gomod", "gowork", "gotmpl" },

	root_markers = { "go.mod", ".git" },

	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
				fieldalignment = true,
				nilness = true,
				unusedwrite = true,
				useany = true,
			},
			staticcheck = true,
			usePlaceholders = true,
			completeUnimported = true,
			experimentalPostfixCompletions = true,
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			codelenses = {
				generate = true,
				gc_details = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
		},
	},
}
