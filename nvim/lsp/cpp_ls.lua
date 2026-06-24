return {
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--completion-style=detailed',
        '--header-insertion=never',
        '--query-driver=C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Tools\\MSVC\\14.44.35207\\bin\\Hostx64\\x64\\cl.exe',
    },
    filetypes = { 'c', 'cpp' },
    capabilities = require('cmp_nvim_lsp').default_capabilities()
}
