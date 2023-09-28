vim.keymap.set('n', '<F9>', function()
	vim.cmd.write()
	vim.cmd.Start { 'as -o %:r.o % --32 && ld -o %:r %:r.o -m elf_i386 && ./%:r; read' }
end)
