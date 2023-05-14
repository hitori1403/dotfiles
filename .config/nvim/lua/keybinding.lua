-- disable mouse
vim.opt.mouse = ''

-- disable arrow keys
for _, mode in ipairs({ 'n', 'i', 'x' }) do
	for _, key in ipairs({ 'Up', 'Down', 'Left', 'Right' }) do
		vim.keymap.set(mode, string.format('<%s>', key), '<Nop>', {})
	end
end
