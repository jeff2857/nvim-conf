local present, treesitter = pcall(require, 'nvim-treesitter')

if not present then
    return
end

require'nvim-treesitter'.setup {
    highlight = {
        enable = true,
        use_languagetree = true,
    },
    indent = {
        enable = true,
    },
}

