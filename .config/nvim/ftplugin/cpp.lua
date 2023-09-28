vim.keymap.set('n', '<F9>', function()
	vim.cmd.write()
	vim.cmd.Start { 'g++ -Wall % -o %:r && ./%:r; read' }
end)
