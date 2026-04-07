vim.lsp.config('*', {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true
})

vim.lsp.enable('cpp_ls')
