return {
    cmd = { 'clangd', '--background-index', '--clang-tidy', '--completion-style=detailed', '--header-insertion=never'},
    filetypes = { 'c', 'cpp' },
    capabilities = require('cmp_nvim_lsp').default_capabilities()
}
