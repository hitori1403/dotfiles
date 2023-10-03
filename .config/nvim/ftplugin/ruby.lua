local toggleterm = require('toggleterm')

vim.keymap.set('n', '<F9>', function()
	vim.cmd.write()
	toggleterm.exec(vim.fn.expandcmd('ruby %'))
end)
