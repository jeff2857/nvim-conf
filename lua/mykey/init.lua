local keymap = require('utils.keymap')


-- switch among windows
keymap.map('n', '<C-j>', '<C-w>j')
keymap.map('n', '<C-k>', '<C-w>k')
keymap.map('n', '<C-h>', '<C-w>h')
keymap.map('n', '<C-l>', '<C-w>l')

-- switch among tabs
keymap.map('n', '<Leader>1', '1gt')
keymap.map('n', '<Leader>2', '2gt')
keymap.map('n', '<Leader>3', '3gt')
keymap.map('n', '<Leader>4', '4gt')
keymap.map('n', '<Leader>5', '5gt')
keymap.map('n', '<Leader>6', '6gt')
keymap.map('n', '<Leader>7', '7gt')
keymap.map('n', '<Leader>8', '8gt')
keymap.map('n', '<Leader>9', '9gt')
keymap.map('n', '<Leader>0', ':tablast<CR>')

-- quit
keymap.map('n', '<Leader>q', ':q<CR>')
-- write buffer
keymap.map('n', '<Leader>w', ':w<CR>')

-- copy to clipboard
keymap.map('v', '<Leader>y', '"+y')
