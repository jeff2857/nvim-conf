local present, lspconfig = pcall(require, 'lspconfig')

if not present then
    return
end

local present, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if not present then
    return
end


local api = vim.api




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

-- how diagnostic displayed
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

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

local keymap = vim.keymap

local opts = { silent = true, noremap = true }

keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
keymap.set('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>')
keymap.set('n', ']e', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>')


local function on_attach(client, bufnr)
    -- highlight symbol under cursor
    require'illuminate'.on_attach(client)

    -- Enable completion triggered by <c-x><c-o>
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
    keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    keymap.set('n', 'gf', vim.lsp.buf.formatting, bufopts)
    keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
    keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
    keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>LspInfo<CR>', opts)
end


-- load lsp servers
-- rust
local present, rt = pcall(require, 'rust-tools')
if not present then
  return
end

rt.setup({
  server = {
    on_attach = function(client, bufnr)
      -- highlight symbol under cursor
      -- require'illuminate'.on_attach(client)
      --
      -- -- Enable completion triggered by <c-x><c-o>
      -- api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      -- api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
      --
      -- local bufopts = { noremap = true, silent = true, buffer = bufnr }
      --
      -- keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      -- keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      -- keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      -- keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
      -- keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
      -- keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      -- keymap.set('n', 'gf', vim.lsp.buf.formatting, bufopts)
      -- keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
      keymap.set('n', '<leader>a', rt.code_action_group.code_action_group, bufopts)
      -- keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
      keymap.set('n', 'K', rt.hover_actions.hover_actions, bufopts)
      api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>LspInfo<CR>', opts)
    end,
  },
})

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
