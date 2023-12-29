return {
	'akinsho/toggleterm.nvim',
	version = "*",
	opts = {},
	config = function()
		vim.keymap.set('n', '<leader>tt', require('toggleterm').toggle)
	end
}
