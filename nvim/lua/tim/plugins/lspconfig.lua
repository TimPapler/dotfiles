return {
	"neovim/nvim-lspconfig",
	name = "lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"towolf/vim-helm",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- Enhanced diagnostic configuration
		vim.diagnostic.config({
			-- Show diagnostics in virtual text with improved formatting
			virtual_text = {
				enabled = true,
				source = "if_many", -- Show source if multiple sources
				prefix = "●",
				spacing = 2,
				severity_sort = true,
			},
			-- Enhanced signs with better icons
			signs = {
				enabled = true,
				priority = 100,
			},
			-- Improved float window diagnostics
			float = {
				enabled = true,
				border = "rounded",
				source = true, -- Always show diagnostic source
				header = "",
				prefix = "",
				suffix = "",
				format = function(diagnostic)
					local source = diagnostic.source and (" [%s]"):format(diagnostic.source) or ""
					return ("%s%s"):format(diagnostic.message, source)
				end,
			},
			-- Update in insert mode for better feedback
			update_in_insert = false,
			-- Sort diagnostics by severity
			severity_sort = true,
		})

		-- Set up capabilities for nvim-cmp
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		if has_cmp then
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
		end
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		-- Enhanced capabilities for modern LSP features
		capabilities.textDocument.inlayHint = {
			dynamicRegistration = true,
			resolveSupport = {
				properties = { "tooltip", "textEdits", "label.tooltip", "label.command" },
			},
		}

		-- Explicitly set definition capability for sourcekit
		capabilities.textDocument.definition = {
			dynamicRegistration = false,
			linkSupport = true,
		}
		-- LSP keymaps using LspAttach autocommand (modern approach)
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				require("tim.config.keymaps").lsp_keymaps(event.buf)

				-- Enable inlay hints if supported
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
				end
			end,
		})

		vim.lsp.config("cssls", {
			capabilities = capabilities,
		})
		vim.lsp.enable("cssls")

		vim.lsp.config("gopls", {
			capabilities = capabilities,
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
		})
		vim.lsp.enable("gopls")

		vim.lsp.config("helm_ls", {
			capabilities = capabilities,
			settings = {
				["helm-ls"] = {
					yamlls = {
						path = "yaml-language-server",
					},
				},
			},
		})
		vim.lsp.enable("helm_ls")

		vim.lsp.config("sourcekit", {
			capabilities = capabilities,
			cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
			filetypes = { "swift", "objc", "objcpp", "c", "cpp", "metal" },
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
		})
		vim.lsp.enable("sourcekit")

		-- Migrate to new vim.lsp.config API
		vim.lsp.config("pyright", {
			capabilities = capabilities,
		})
		vim.lsp.enable("pyright")

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							"${3rd}/luv/library",
						},
					},
					completion = {
						callSnippet = "Replace",
					},
					hint = {
						enable = true,
						setType = false,
						paramType = true,
						paramName = "Disable",
						semicolon = "Disable",
						arrayIndex = "Disable",
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("ruby-lsp")

		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = false,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = false,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
		})
		vim.lsp.enable("ts_ls")

		vim.lsp.config("yamlls", {
			capabilities = capabilities,
			settings = {
				yaml = {
					schemas = {
						["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
						["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v2.0/schema.json"] = "*/spec/*.yaml",
						["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
					},
				},
			},
		})
		vim.lsp.enable("yamlls")
		-- nice icons
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end
	end,
}
