-- [[ lazy.nvim 

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- ]]

require("keybinding")

-- Show line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Disable prompt mode below status line
vim.opt.showmode = false

-- Tab size
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Colorshcheme
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1

vim.cmd.colorscheme('gruvbox-material')

-- Cause all splits to happen below
vim.opt.splitbelow = true
