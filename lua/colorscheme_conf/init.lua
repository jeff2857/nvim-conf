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
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_ui_contrast = 'high'
    vim.g.gruvbox_material_better_performance = 1
    vim.cmd[[silent! colorscheme gruvbox-material]]
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
    end
end

loadColorScheme'sonokai'

