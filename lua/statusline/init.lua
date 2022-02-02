local M = {}

function M.setup()
    local mode = '%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}'
    local fileName = '%-f'
    local modified = '%-m'
    local rightAlign = '%='
    local lineNo = '%10([%l/%L%)]'
    local pctFile = '%5p%%'

    --[[
    vim.opt.statusline = string.format(
        '%s%s%s%s%s%s',
        mode,
        fileName,
        modified,
        rightAlign,
        lineNo,
        pctFile
    )
    ]]--
end

return M
