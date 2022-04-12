local present, cmp = pcall(require, 'cmp')

if not present then
    return
end

local present, luasnip = pcall(require, 'luasnip')

if not present then
    return
end

local present, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if not present then
    return
end

local present, lspconfig = pcall(require, 'lspconfig')
if not present then
    return
end

local present, luasnip = pcall(require, 'luasnip')
if not present then
    return
end


vim.opt.completeopt = 'menuone,noinsert,noselect'

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = '[LSP]',
                nvim_lua = '[LUA]',
                buffer = '[BUF]',
            })[entry.source.name]

            return vim_item
        end
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            --elseif luasnip.expand_or_jumpable() then
            --    luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            --elseif luasnip.jumpable(-1) then
            --    luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = {
        {name = 'nvim_lsp'},
        {name = 'luasnip'},
        {name = 'buffer'},
        {name = 'nvim_lua'},
        {name = 'path'},
        {name = 'nvim_lsp_signature_help'},
    },
}


luasnip.config.set_config {
    history = true,
    updateevents = 'TextChanged,TextChangedI',
}

require('luasnip/loaders/from_vscode').load()

