return {
    {
	    'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'c', 'cpp', 'powershell', 'json', 'yaml', 'cmake' },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    }
}
