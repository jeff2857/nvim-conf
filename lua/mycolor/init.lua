local present, colorscheme = pcall(require, 'vim-moonfly-colors')

if not present then
    return
end

vim.cmd[[colorscheme moonfly]]
