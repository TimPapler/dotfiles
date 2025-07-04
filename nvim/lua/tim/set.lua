-- vim.opt.guicursor = ""

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

vim.opt.nu = true
vim.opt.relativenumber = true
vim.updatetime = 250 -- decrease update time

-- decrease update time
-- displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Enable break indent
vim.opt.breakindent = true

-- always show sign colorcolumn
vim.opt.signcolumn = "yes"

vim.g.have_nerd_font = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
-- vim.opt.expandtab = true -- what ever doesnt do what you'd expect

vim.opt.smartindent = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default

vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Make window separators more distinct - "Plasma Field" style
vim.opt.fillchars = {
	vert = "▌",      -- Left half block (energy field)
	horiz = "▀",     -- Upper half block (force field)
	horizup = "▛",   -- Quadrant upper left + right
	horizdown = "▜", -- Quadrant upper right + lower  
	vertleft = "▐",  -- Right half block
	vertright = "▌", -- Left half block
	verthoriz = "▚", -- Diagonal quadrants (plasma intersection)
}

vim.filetype.add({
	extension = {
		metal = "metal",
	},
})
