-- vim.opt.guicursor = ""

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Allow backspace to delete across lines
vim.opt.backspace = { "indent", "eol", "start" }

vim.opt.nu = true
vim.opt.relativenumber = true

-- decrease update time
-- displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Disable break indent since wrapping is disabled
vim.opt.breakindent = false

-- always show sign colorcolumn
vim.opt.signcolumn = "yes"

vim.g.have_nerd_font = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default

vim.opt.termguicolors = true

-- Built-in completion settings
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.pumheight = 10  -- Max items in completion menu
vim.opt.scrolloff = 10
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"


-- Option 9: Minimalist dots
-- vim.opt.fillchars = {
-- 	vert = "·",
-- 	horiz = "·",
-- 	horizup = "·",
-- 	horizdown = "·",
-- 	vertleft = "·",
-- 	vertright = "·",
-- 	verthoriz = "·",
-- }

-- Option 10: Hexagonal/Honeycomb
-- vim.opt.fillchars = {
-- 	vert = "⬡",
-- 	horiz = "⬡",
-- 	horizup = "⬡",
-- 	horizdown = "⬡",
-- 	vertleft = "⬡",
-- 	vertright = "⬡",
-- 	verthoriz = "⬡",
-- }

vim.filetype.add({
	extension = {
		metal = "metal",
	},
})
