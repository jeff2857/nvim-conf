local keymap = require('utils.keymap')


-- switch among windows
keymap.map('n', '<C-j>', '<C-w>j')
keymap.map('n', '<C-k>', '<C-w>k')
keymap.map('n', '<C-h>', '<C-w>h')
keymap.map('n', '<C-l>', '<C-w>l')

-- switch among tabs
keymap.map('n', '<Leader>1', 'gt0')
keymap.map('n', '<Leader>2', 'gt1')
keymap.map('n', '<Leader>3', 'gt2')
keymap.map('n', '<Leader>4', 'gt3')
keymap.map('n', '<Leader>5', 'gt4')
keymap.map('n', '<Leader>6', 'gt5')
