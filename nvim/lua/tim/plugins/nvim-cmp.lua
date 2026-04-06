-- Disabled: using native Neovim 0.12 completion (autocomplete + vim.lsp.completion)
-- To re-enable, set enabled = true and disable autocomplete in set.lua
return {
	"hrsh7th/nvim-cmp",
	enabled = false,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
	},
}
