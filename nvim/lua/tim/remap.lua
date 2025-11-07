-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set highlight on search
vim.opt.hlsearch = true

-- Load keymaps from config
require('tim.config.keymaps').setup()