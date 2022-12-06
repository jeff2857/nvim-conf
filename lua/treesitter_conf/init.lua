local present, treesitter = pcall(require, 'nvim-treesitter')

if not present then
    return
end

require'nvim-treesitter'.setup {
    ensure_installed = {'lua', 'rust', 'toml'},
    auto_install = true,
    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    }
}

