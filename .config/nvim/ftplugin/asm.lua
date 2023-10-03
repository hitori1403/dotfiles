local toggleterm = require('toggleterm')

vim.keymap.set('n', '<F9>', function()
	vim.cmd.write()
	toggleterm.exec(vim.fn.expandcmd('as -o %:r.o % --32 && ld -o %:r %:r.o -m elf_i386 && ./%:r')
end)
