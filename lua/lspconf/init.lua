local present, lspconfig = pcall(require, 'lspconfig')

if not present then
    return
end

local present, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if not present then
    return
end


local api = vim.api


-- how diagnostic displayed
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
})


-- diagnostic symbols
local signs = {
    Error = ' ',
    Warn = ' ',
    Hint = ' ',
    Info = ' ',
}
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- print diagnostics to message area
function PrintDiagnostics(opts, bufnr, line_nr, client_id)
    bufnr = bufnr or 0
    line_nr = line_nr or (api.nvim_win_get_cursor(0)[1] - 1)
    opts = opts or {['lnum'] = line_nr}

    local line_diagnostics = vim.diagnostic.get(bufnr, opts)
    if vim.tbl_isempty(line_diagnostics) then return end

    local diagnostic_message = ''
    for i, diagnostic in ipairs(line_diagnostics) do
        diagnostic_message = diagnostic_message .. string.format('%d: %s', i, diagnostic_message or '')
        print(diagnostic_message)
        if i ~= #line_diagnostics then
            diagnostic_message = diagnostic_message .. '\n'
        end
    end
    api.nvim_echo({{diagnostic_message, 'Normal'}}, false, {})
end

vim.cmd [[ autocmd! CursorHold * lua PrintDiagnostics() ]]


-- show line diagnostics automatically in hover window
vim.o.updatetime = 200
vim.cmd [[ autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]


-- Add additional capabilities support by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities();
capabilities = cmp_lsp.update_capabilities(capabilities);

vim.cmd [[ autocmd! BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200) ]]

-- lsp keymap

local keymap = require'utils.keymap'


keymap.map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
keymap.map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
keymap.map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>')
keymap.map('n', ']e', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>')

local opts = { silent = true, noremap = true }

local function on_attach(client, bufnr)
    -- highlight symbol under cursor
    require'illuminate'.on_attach(client)

    -- Enable completion triggered by <c-x><c-o>
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

    api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>LspInfo<CR>', opts)
end


-- load lsp servers
local servers = { 'rust_analyzer' }
for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            ["rust-analyzer"] = {
                assist = {
                    importGranularity = 'module',
                    importPrefix = 'self',
                },
                cargo = {
                    loadOutDirsFromCheck = true,
                },
                procMacro = {
                    enable = true,
                },
            }
        }
    }
end

-- solidity
--lspconfig['solc'].setup{
    --on_attach = on_attach,
    --flags = {
        --debounce_text_changes = 150,
    --},
    --cmd = {'solc', '--lsp'},
    --init_options = {hostInfo = "neovim"},
    --filetypes = {"solidity"},
    --root_dir = lspconfig.util.root_pattern('hardhat.config.*', '.git'),
--}

lspconfig['solidity_ls'].setup{
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    cmd = {'solidity-language-server', '--stdio'},
    filetypes = {'solidity'},
    root_dir = lspconfig.util.root_pattern('package.json', '.git'),
}

lspconfig['tsserver'].setup{
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    cmd = {'typescript-language-server', '--stdio'},
    init_options = {hostInfo = 'neovim'},
    filetypes = {'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx'},
    root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
}

lspconfig['clangd'].setup{
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    cmd = {'clangd'},
    filetypes = {'c', 'cpp'},
    root_dir = lspconfig.util.root_pattern('.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git'),
    single_file_support = true,
}
