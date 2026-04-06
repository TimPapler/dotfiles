return { -- Kept as xcodebuild.nvim dependency
	"nvim-telescope/telescope.nvim",
	cmd = { "Telescope" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = function() return vim.fn.executable("make") == 1 end },
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = "▸ ",
				path_display = { "truncate" },
				file_ignore_patterns = { "%.git/", "node_modules", "%.npm/", "__pycache__", "%.DS_Store" },
			},
			extensions = {
				["ui-select"] = { require("telescope.themes").get_dropdown() },
			},
		})
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
	end,
}
