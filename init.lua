local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local exec = vim.api.nvim_exec
local wo = vim.wo


-- install packer.nvim
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- use packer.nvim as plugin manager
cmd [[packadd packer.nvim]]


-- auto source nvim config
exec([[
    aug AutoSourceVimConfig
        autocmd!
        autocmd BufWritePost $MYVIMRC source $MYVIMRC
    aug end
]], false)


-- leader
g.mapleader = ';'

-- enable terminal colors
opt.termguicolors = true

-- line number
opt.number = true
opt.relativenumber = true

-- indent
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
-- no word wrap
wo.wrap = false

-- highlight line and column
opt.cursorcolumn = true
opt.cursorline = true

-- cursor shape
opt.guicursor = 'a:block'

-- minimal number of screen lines to keep above and below the cursor
opt.scrolloff = 3

opt.hidden = true
opt.swapfile = false
opt.wildmenu = true
opt.lazyredraw = true
opt.synmaxcol = 240

-- search
opt.ignorecase = true

-- split
opt.splitbelow = true
opt.splitright = true

-- color scheme
--cmd[[colorscheme gruvbox-material]]
--require'mycolor'
--[[
g.gruvbox_material_background = 'hard'
g.gruvbox_material_enable_italic = 1
g.gruvbox_material_disable_italic_comment = 0
g.gruvbox_material_enable_bold = 1
g.gruvbox_material_ui_contrast = 'high'
g.gruvbox_material_better_performance = 1
g.gruvbox_material_palette = {
    bg0 = {'#101010', '234'},
    bg1 = {'#262727', '235'},
    bg2 = {'#282828', '235'},
    bg3 = {'#3c3836', '237'},
    bg4 = {'#3c3836', '237'},
    bg5 = {'#504945', '239'},
    bg_statusline1 = {'#282828', '235'},
    bg_statusline2 = {'#32302f', '235'},
    bg_statusline3 = {'#504945', '239'},
    bg_diff_green = {'#32361a', '22'},
    bg_visual_green = {'#335e34', '22'},
    bg_diff_red = {'#3c1f1e', '52'},
    bg_visual_red = {'#442e2d', '52'},
    bg_diff_blue = {'#0d3138', '17'},
    bg_visual_blue = {'#2e3b3b', '17'},
    bg_visual_yellow = {'#473c29', '94'},
    bg_current_word = {'#32302f', '236'},
    fg0 = {'#d4be98', '223'},
    fg1 = {'#ddc7a1', '223'},
    red = {'#ea6962', '167'},
    orange = {'#e78a4e', '208'},
    yellow = {'#d8a657', '214'},
    green = {'#a9b665', '142'},
    aqua = {'#89b482', '108'},
    blue = {'#7daea3', '109'},
    purple = {'#d3869b', '175'},
    bg_red = {'#ea6962', '167'},
    bg_green = {'#a9b665', '142'},
    bg_yellow = {'#d8a657', '214'},
    grey0 = {'#7c6f64', '243'},
    grey1 = {'#928374', '245'},
    grey2 = {'#a89984', '246'},
    none = {'NONE', 'NONE'}
}
]]--

--[[ this need to be repaired
local present, gruvboxScheme = pcall(require, 'gruvbox-material')
if present then
    cmd'colorscheme gruvbox-material'
end
]]--

--cmd'colorscheme gruvbox-material'

-- colorscheme sonokai
-- available style: default, atlantis, andromeda, shusia, maia, espresso
g.sonokai_style = 'maia'
g.sonokai_enable = 1
cmd[[colorscheme sonokai]]


-- statusline
-- opt.laststatus = 2


-- plugin configurations

-- nvim-tree
require'nvim_tree'

-- telescope
require'telescope_conf'

-- lspconfig
require'lspconf'

-- autocompletion
require'autocmp'

-- treesitter
require'treesitter_conf'

-- neoscroll
require'scroll_conf'


-- custom keymap

-- my keymap
require('mykey')


-- packer plugin management
local present, packer = pcall(require, 'packer')

if not present then
    return
end

packer.init()
packer.startup(function ()
    -- packer manage itself
    use 'wbthomason/packer.nvim'

    -- file tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons'
        },
        config = function()
            require 'nvim-tree'.setup {
                view = {
                    mappings = {
                        list = require'nvim_tree'
                    }
                }
            }
        end
    }

    -- statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        event = 'VimEnter',
        config = function()
            require'lualine'.setup {
                options = {
                    theme = 'sonokai'
                }
            }
        end
    }

    -- lsp
    use {
        'neovim/nvim-lspconfig'
    }

    -- color scheme
    use {
        'sainnhe/gruvbox-material',
        config = function()
            --cmd[[colorscheme gruvbox-material]]
        end
    }

    use {
        'sainnhe/sonokai',
        config = function()
        end
    }

    use {
        'bluz71/vim-moonfly-colors'
    }

    use {
        'karb94/neoscroll.nvim',
        config = function()
            require'neoscroll'.setup()
        end
    }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    -- lspsaga
    use {
        'glepnir/lspsaga.nvim'
    }

    -- Java language server
    use {
        'mfussenegger/nvim-jdtls'
    }

    -- gitsigns
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require'gitsigns'.setup()
        end
    }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    -- autopairs
    use {
        'windwp/nvim-autopairs',
        config = function()
            require'nvim-autopairs'.setup{}
        end
    }

    -- indent line
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require'indent_blankline'.setup {
                show_current_context = true,
                show_current_context_start = true,
            }
        end
    }

    -- autocomplete
    use {
        'hrsh7th/cmp-nvim-lsp',
        --after = 'cmp-nvim-lua',
    }

    use {
        'hrsh7th/cmp-buffer',
        --after = 'cmp-nvim-lsp',
    }

    use {
        'hrsh7th/cmp-path',
        --after = 'cmp-buffer',
    }

    use {
        'hrsh7th/cmp-cmdline',
    }

    use {
        'hrsh7th/nvim-cmp',
        --after = 'friendly-snippets',
    }

    use {
        'rafamadriz/friendly-snippets',
        --event = 'InsertEnter',
    }

    use {
        'L3MON4D3/LuaSnip',
        --wants = 'friendly-snippets',
        --after = 'nvim-cmp',
    }

    use {
        'saadparwaiz1/cmp_luasnip',
        --after = 'LuaSnip',
    }

    use {
        'hrsh7th/cmp-nvim-lua',
        --after = 'cmp_luasnip',
    }

    use {
        'tomlion/vim-solidity',
    }

end)
