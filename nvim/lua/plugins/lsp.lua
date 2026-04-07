return {
    {
	    'neovim/nvim-lspconfig',
	    lazy = true
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = 'VeryLazy',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'cpp' },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    }
}
