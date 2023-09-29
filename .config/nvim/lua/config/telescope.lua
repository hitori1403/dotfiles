local telescope = require("telescope")
local builtin = require('telescope.builtin')
local extensions = telescope.extensions

telescope.setup {
	extensions = {
		file_browser = {
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true
		},
		["ui-select"] = {
			require('telescope.themes').get_dropdown {}
		}
	}
}

telescope.load_extension "file_browser"
telescope.load_extension "ui-select"

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<space>fb", extensions.file_browser.file_browser, {})
