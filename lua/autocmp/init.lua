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
          vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = '[LSP]',
                vsnip = '[snip]',
                nvim_lua = '[LUA]',
                buffer = '[BUF]',
                path='[PATH]',
            })[entry.source.name]

            return vim_item
        end
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    },
    sources = {
      {name = 'path'},
        {name = 'nvim_lsp', keyword_length = 3},
        {name = 'vsnip', keyword_length = 2},
        {name = 'buffer', keyword_length = 2},
        {name = 'calc'},
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

