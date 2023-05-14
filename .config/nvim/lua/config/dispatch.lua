local runners = {
	{ 'asm',        'as -o %:r.o % --32 && ld -o %:r %:r.o -m elf_i386 && ./%:r' },
	{ 'c',          'gcc -Wall % -o %:r && ./%:r' },
	{ 'cpp',        'g++ -Wall % -o %:r && ./%:r' },
	{ 'java',       'javac % && java %:r' },
	{ 'javascript', 'node %' },
	{ 'php',        'php %' },
	{ 'python',     'python %' },
}

for _, r in ipairs(runners) do
	vim.api.nvim_create_autocmd('FileType', {
		pattern = r[1],
		callback = function()
			vim.keymap.set('n', '<F9>', function()
				vim.cmd.write()
				vim.cmd.Start { r[2] .. ';read' }
			end)
		end
	})
end
