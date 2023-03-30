require("plugins")
require("keybinding")

-- disable mouse
vim.opt.mouse = ''

-- Show line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Disable prompt mode below status line
vim.opt.showmode = false

-- Tab size
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Colorshcheme
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1

vim.cmd([[colorscheme gruvbox-material]])
