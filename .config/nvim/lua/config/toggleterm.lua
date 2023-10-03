local toggleterm = require('toggleterm')

toggleterm.setup()

vim.keymap.set('n', '<leader>tt', toggleterm.toggle)
