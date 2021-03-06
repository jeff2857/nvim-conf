local present, tree = pcall(require, 'nvim-tree.config')

if not present then
    return
end

local keymap = require('utils.keymap')
local tree_cb = tree.nvim_tree_callback

local g = vim.g


-- key bindings

-- toggle nvim-tree
keymap.map('n', '<C-n>', ':NvimTreeToggle<CR>')
-- refresh
keymap.map('n', '<Leader>r', ':NvimTreeRefresh<CR>')
-- find file
keymap.map('n', '<Leader>n', ':NvimTreeFindFile<CR>')

-- nvim-tree callback
local list = {
    { key = 's', cb = tree_cb('split') },
    { key = 'v', cb = tree_cb('vsplit') },
    { key = 't', cb = tree_cb('tabnew') },
    { key = '?', cb = tree_cb('toggle_help') },
}

return list
