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
				source = true,
				header = "",
				prefix = "",
				suffix = "",
			},
			-- Update in insert mode for better feedback
			update_in_insert = false,
			-- Sort diagnostics by severity
			severity_sort = true,
		})

		-- LSP capabilities
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities.textDocument.inlayHint = {
			dynamicRegistration = true,
			resolveSupport = {
				properties = { "tooltip", "textEdits", "label.tooltip", "label.command" },
			},
		}
		capabilities.textDocument.definition = {
			dynamicRegistration = false,
			linkSupport = true,
		}

		-- Constrain floating preview dimensions and enable word wrap
		local orig_open_floating_preview = vim.lsp.util.open_floating_preview
		vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
			opts = opts or {}
			opts.max_width = opts.max_width or 80
			opts.max_height = opts.max_height or 40
			local bufnr, winnr = orig_open_floating_preview(contents, syntax, opts)
			if winnr then
				vim.wo[winnr].wrap = true
				vim.wo[winnr].linebreak = true
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

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if not client then
					return
				end

				-- Enable native LSP completion (Neovim 0.12+)
				if client:supports_method("textDocument/completion") then
					vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
				end

				-- Enable inlay hints if supported
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
				end
			end,
		})

		-- Clean up completion when LSP client detaches
		vim.api.nvim_create_autocmd("LspDetach", {
			desc = "LSP cleanup",
			callback = function(event)
				vim.lsp.completion.enable(false, event.data.client_id, event.buf)
			end,
		})

		-- Override lspconfig's built-in sourcekit cmd (it drops xcrun)
		vim.lsp.config("sourcekit", {
			cmd = { "xcrun", "sourcekit-lsp" },
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
