vim.keymap.set('n', '<F9>', function()
	vim.cmd.write()
	require('toggleterm').exec('cargo run')
end)
