local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt


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

-- highlight line and column
opt.cursorcolumn = true
opt.cursorline = true

-- cursor shape
opt.guicursor = 'a:block'

-- minimal number of screen lines to keep above and below the cursor
opt.scrolloff = 3


-- color scheme
--cmd[[colorscheme gruvbox-material]]
--require'mycolor'
cmd[[colorscheme moonfly]]

-- statusline
-- opt.laststatus = 2


-- plugins
cmd [[packadd packer.nvim]]


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
                    theme = 'moonfly'
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
        'bluz71/vim-moonfly-colors'
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
