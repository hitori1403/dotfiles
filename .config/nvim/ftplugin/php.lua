vim.keymap.set('n', '<F9>', function()
	vim.cmd.write()
	vim.cmd.Start { 'php %; read' }
end)
