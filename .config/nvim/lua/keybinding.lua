-- Disable mouse
vim.opt.mouse = ''

-- Disable arrow keys
for _, key in ipairs({ 'Up', 'Down', 'Left', 'Right' }) do
	vim.keymap.set({ 'n', 'i', 'x' }, string.format('<%s>', key), '<Nop>')
end
