return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	config = function()
		require("kanagawa").setup({
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false,
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = { -- add/modify theme and palette colors
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(colors)
				return {
					WinSeparator = { fg = colors.palette.sakuraPink, bg = colors.palette.sumiInk1 },
					VertSplit = { fg = colors.palette.sakuraPink, bg = colors.palette.sumiInk1 },
				}
			end,
			theme = "wave", -- Load "wave" theme
			background = { -- map the value of 'background' option to a theme
				dark = "wave",
				light = "lotus",
			},
		})

		vim.cmd("colorscheme kanagawa")
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#363646" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e6c384", bold = true })
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "kanagawa",
			callback = function()
				if vim.o.background == "light" then
					vim.fn.system("kitty +kitten themes Kanagawa_light")
				elseif vim.o.background == "dark" then
					vim.fn.system("kitty +kitten themes Kanagawa_dragon")
				else
					vim.fn.system("kitty +kitten themes Kanagawa")
				end
			end,
		})
	end,
}
