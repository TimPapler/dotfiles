return {
	"rebelot/kanagawa.nvim",
	mame = "kanagawa",
	config = function()
		require("kanagawa").setup({
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = true, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = { -- add/modify theme and palette colors
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(colors) -- add/modify highlights
				local theme = colors.theme
				return {

					-- Make window separators with sakura pink accent
					WinSeparator = { fg = colors.palette.sakuraPink, bg = colors.palette.sumiInk1 },
					VertSplit = { fg = colors.palette.sakuraPink, bg = colors.palette.sumiInk1 },
					
					-- Alternative color options (uncomment one):
					-- Subtle purple/violet
					-- WinSeparator = { fg = colors.palette.oniViolet, bg = colors.palette.sumiInk1 },
					-- VertSplit = { fg = colors.palette.oniViolet, bg = colors.palette.sumiInk1 },
					
					-- Aqua/cyan (calming)
					-- WinSeparator = { fg = colors.palette.waveAqua2, bg = colors.palette.sumiInk1 },
					-- VertSplit = { fg = colors.palette.waveAqua2, bg = colors.palette.sumiInk1 },
					
					-- Soft pink/sakura
					-- WinSeparator = { fg = colors.palette.sakuraPink, bg = colors.palette.sumiInk1 },
					-- VertSplit = { fg = colors.palette.sakuraPink, bg = colors.palette.sumiInk1 },
					
					-- Muted green
					-- WinSeparator = { fg = colors.palette.springGreen, bg = colors.palette.sumiInk1 },
					-- VertSplit = { fg = colors.palette.springGreen, bg = colors.palette.sumiInk1 },
					
					-- Subtle gray (minimal)
					-- WinSeparator = { fg = colors.palette.sumiInk4, bg = colors.palette.sumiInk1 },
					-- VertSplit = { fg = colors.palette.sumiInk4, bg = colors.palette.sumiInk1 },
				}
			end,
			theme = "wave", -- Load "wave" theme
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
				light = "lotus",
			},
		})

		vim.cmd("colorscheme kanagawa")
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
