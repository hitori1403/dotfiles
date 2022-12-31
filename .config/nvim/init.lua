require("plugins")

-- disable mouse
vim.opt.mouse = ''

-- Show line number
vim.opt.number = true
vim.opt.relativenumber = true

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

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- disable arrow keys
for _, mode in ipairs({ 'n', 'i', 'x' }) do
	for _, key in ipairs({ 'Up', 'Down', 'Left', 'Right' }) do
		vim.keymap.set(mode, string.format('<%s>', key), '<Nop>', {})
	end
end
