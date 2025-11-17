require('config.lazy').setup(require('plugins'))

vim.lsp.config('*', {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true
})

vim.lsp.enable('cpp_ls')

vim.opt.list = true
vim.opt.listchars = {
    tab = '▷ ',
    trail = '█',
    extends = '◣',
    precedes = '◢',
    nbsp = '○'
}

vim.cmd('set termguicolors')
vim.cmd('set number')
vim.cmd('set colorcolumn=100')
vim.cmd('set tabstop=4')
vim.cmd('set shiftwidth=4')
vim.cmd('set expandtab')
vim.cmd('set clipboard=unnamed')
vim.cmd('set autoindent')
vim.cmd('set smartindent')
vim.cmd('set cindent')
--vim.cmd('set background=light')
vim.cmd('colorscheme catppuccin-frappe')
