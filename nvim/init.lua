require('config.lazy').setup(require('plugins'))

vim.lsp.config('*', {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true
})

vim.lsp.enable('cpp_ls')

vim.cmd('set termguicolors')
vim.cmd('set number')
vim.cmd('set colorcolumn=100')
vim.cmd('set relativenumber')
vim.cmd('set tabstop=4')
vim.cmd('set shiftwidth=4')
vim.cmd('set expandtab')
vim.cmd('set clipboard=unnamed')
vim.cmd('colorscheme everforest')
