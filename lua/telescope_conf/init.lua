local keymap = require'utils.keymap'

keymap.map('n', '<Leader>f', '<cmd>Telescope find_files<cr>')
keymap.map('n', '<Leader>F', '<cmd>Telescope live_grep<cr>')
