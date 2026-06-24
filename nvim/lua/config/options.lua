local options = {
    autoindent = true,
    cindent = true,
    clipboard = 'unnamed',
    colorcolumn = '100',
    cursorline = true,
    expandtab = true,
    list = true,
    listchars = {
        tab = '▷ ',
        trail = '_',
        extends = '◣',
        precedes = '◢',
        nbsp = '○'
    },
    number = true,
    shiftwidth = 4,
    smartindent = true,
    tabstop = 4,
    termguicolors = true
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.o.confirm = false
