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

opt.mouse = 'a'
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
-- available style: default, atlantis, andromeda, shusia, maia, espresso
--g.sonokai_style = 'maia'
--g.sonokai_enable = 1
--cmd[[silent! colorscheme sonokai]]

require'colorscheme_conf'

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

-- status
require'status_conf'

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
                open_on_tab = true,
                hijack_cursor = true,
                respect_buf_cwd = true,
                view = {
                    hide_root_folder = true,
                    mappings = {
                        --list = require'nvim_tree'
                    }
                },
                renderer = {
                    indent_markers = {
                        enable = false,
                    },
                    highlight_git = true,
                    highlight_opened_files = 'all',
                    root_folder_modifier = ':p:.',
                    group_empty = true,
                    icons = {
                        show = {
                            git = false,
                            folder = true,
                            file = false,
                            folder_arrow = true,
                        },
                        glyphs = {
                            folder = {
                                arrow_open = '',
                                arrow_closed = '',
                            },
                        },
                    },
                },
                actions = {
                    open_file = {
                        quit_on_open = false,
                        window_picker = {
                            enable = false,
                        },
                        resize_window = true,
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
        'neovim/nvim-lspconfig',
    }

    use {
        'RRethy/vim-illuminate',
    }

    -- lsp status
    use {
        'nvim-lua/lsp-status.nvim',
        config = function()
        end
    }

    -- color scheme
    use {
        'sainnhe/sonokai',
    }

    use {
        'projekt0n/github-nvim-theme',
    }

    use {
        'maxmellon/vim-jsx-pretty'
    }

    use {
        'lewpoly/sherbet.nvim',
    }

    use {
        'sainnhe/gruvbox-material',
    }

    use {
        'Th3Whit3Wolf/one-nvim',
    }

    use {
        'kyazdani42/blue-moon'
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

    -- tabline
    use {
        'alvarosevilla95/luatab.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require'luatab'.setup {}
        end,
    }

end)
