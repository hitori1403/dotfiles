local toggleterm = require('toggleterm')

if vim.bo.filetype == 'c' then
	cmd = 'gcc -Wall % -o %:r && ./%:r'
else
	cmd = 'g++ -Wall % -o %:r && ./%:r'
end

vim.keymap.set('n', '<F9>', function()
	vim.cmd.write()
	toggleterm.exec(vim.fn.expandcmd(cmd))
end)
