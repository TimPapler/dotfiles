return {
	"neovim/nvim-lspconfig",
	name = "lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"towolf/vim-helm",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- Define diagnostic signs (legacy API for compatibility with Trouble, etc.)
		local signs = {
			{ name = "DiagnosticSignError", text = " " },
			{ name = "DiagnosticSignWarn", text = " " },
			{ name = "DiagnosticSignHint", text = "󰠠 " },
			{ name = "DiagnosticSignInfo", text = " " },
		}
		for _, sign in ipairs(signs) do
			vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
		end

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
			-- Enhanced signs with better icons (modern Neovim 0.10+ API)
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
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

		-- Override open_floating_preview to set max width globally (before LSP attach)
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
			opts = opts or {}
			opts.border = opts.border or "rounded"
			opts.max_width = opts.max_width or 80
			opts.max_height = opts.max_height or 40
			local bufnr, winnr = orig_util_open_floating_preview(contents, syntax, opts)
			-- Enable word wrap in the floating window
			if winnr then
				vim.wo[winnr].wrap = true
				vim.wo[winnr].linebreak = true -- wrap at word boundaries
			end
			return bufnr, winnr
		end

		-- Set global config for all LSP servers (applies to lsp/*.lua configs too)
		vim.lsp.config("*", {
			capabilities = capabilities,
		})
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

		-- Enable LSP servers (configs loaded from lsp/*.lua)
		vim.lsp.enable("cssls")
		vim.lsp.enable("gopls")
		vim.lsp.enable("helm_ls")
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("metal_lsp")
		vim.lsp.enable("pyright")
		vim.lsp.enable("ruby-lsp")
		vim.lsp.enable("sourcekit")
		vim.lsp.enable("ts_ls")
		vim.lsp.enable("yamlls")
	end,
}
