-- disable arrow keys
for _, mode in ipairs({ 'n', 'i', 'x' }) do
	for _, key in ipairs({ 'Up', 'Down', 'Left', 'Right' }) do
		vim.keymap.set(mode, string.format('<%s>', key), '<Nop>', {})
	end
end

local runners = {
	{ 'Run PHP file',    'php',    '<F5>', 'php %' },
	{ 'Run Python file', 'python', '<F5>', 'python %' },
	{ 'Run Python in .mainfile', 'python', '<F6>',
		'python $([[ -f .mainfile ]] && cat .mainfile || echo %)' },
	{ 'Run Javascript file', 'javascript', '<F5>', 'node %' }
}

local save_and_open_new_terminal =
[[:w<CR>:silent !alacritty -e bash -c '%s; read -p "Press ENTER to continue..."; exit'<CR>]]

for _, params in ipairs(runners) do
	vim.api.nvim_create_autocmd('FileType', {
		desc = params[1],
		pattern = params[2],
		callback = function()
			vim.keymap.set('n', params[3], string.format(save_and_open_new_terminal, params[4]), { noremap = true })
		end
	})
end
