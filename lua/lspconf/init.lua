local present, lsp = pcall(require, 'lspconfig')

if not present then
    return
end


-- load typescript language server
lsp.tsserver.setup {}

-- load solidity language server
lsp.solc.setup {}

-- load rust language server
lsp.rust_analyzer.setup {}
