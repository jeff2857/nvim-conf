function loadGithubTheme ()
    local present, github_theme = pcall(require, 'github-theme')

    if not present then
        return
    end

    github_theme.setup{
        theme_style = 'dark',
        function_style = 'italic'
    }
end

function loadSherbet ()
    local present, sherbet = pcall(require, 'sherbet')
    if not present then
        return
    end

    vim.g.sherbet_italic_keywords = true
    vim.g.sherbet_italic_functions = true
    vim.g.sherbet_italic_comments = true
    vim.g.sherbet_italic_loops = true
    vim.g.sherbet_italic_conditionals = true
    vim.cmd[[silent! colorscheme sherbet]]
end

function loadSonokai ()
    vim.g.sonokai_style = 'maia'
    vim.g.sonokai_enable_italic = 1
    vim.g.sonokai_better_performance = 1
    vim.cmd[[silent! colorscheme sonokai]]
end

function loadGruvbox ()
    vim.cmd[[set background=dark]]
    vim.cmd[[let g:gruvbox_material_background = 'dark']]
    vim.cmd[[let g:gruvbox_material_foreground = 'original']]
    vim.cmd[[let g:gruvbox_material_better_performance = 1]]
    vim.cmd[[let g:gruvbox_material_enable_bold = 1]]
    vim.cmd[[let g:gruvbox_material_enable_italic = 1]]
    vim.cmd[[let g:gruvbox_material_ui_contrast = 'high']]
    vim.cmd[[let g:gruvbox_material_visual = 'reverse']]
    vim.cmd[[let g:gruvbox_material_sign_column_background = 'grey']]
    vim.cmd[[let g:gruvbox_material_diagnostic_text_highlight = 1]]
    vim.cmd[[let g:gruvbox_material_diagnostic_line_highlight = 1]]
    vim.cmd[[let g:gruvbox_material_diagnostic_virtual_text = 'colored']]
    vim.cmd[[let g:gruvbox_material_colors_override = {'bg0': ['#24292e', 'NONE'], 'bg2': ['#1f2428', 'NONE']}]]
    vim.cmd[[silent! colorscheme gruvbox-material]]
end

function loadBlueMoon()
    vim.cmd[[silent! colorscheme blue-moon]]
end

function loadOneNvim()
    vim.cmd[[silent! colorscheme one-nvim]]
end

function loadColorScheme (scheme)
    if scheme == 'github' then
        loadGithubTheme()
    elseif scheme == 'sherbet' then
        loadSherbet()
    elseif scheme == 'sonokai' then
        loadSonokai()
    elseif scheme == 'gruvbox' then
        loadGruvbox() 
    elseif scheme == 'onenvim' then
        loadOneNvim()
    else
        loadBlueMoon()
    end
end

loadColorScheme'onenvim'

