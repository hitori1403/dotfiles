local toggleterm = require('toggleterm')

vim.opt.filetype = 'nasm'

vim.keymap.set('n', '<F9>', function()
	vim.cmd.write()
	toggleterm.exec(vim.fn.expandcmd('nasm -felf64 % && gcc %:r.o -o %:r && ./%:r'))
end)
