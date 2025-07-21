return{
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        config = function()
            vim.lsp.enable('clangd')
            vim.lsp.enable('cmake')
        end
    },
    { 
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = 'BufReadPre',
        config = function()
            require('nvim-treesitter.configs').setup({
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    { 
        'lunarvim/lunar.nvim', 
        lazy = false 
    },
    { 
        'lukas-reineke/indent-blankline.nvim', 
        event = 'VeryLazy',
        config = function()
            require('ibl').setup()
        end
    },
	{ 
        'nvim-lualine/lualine.nvim', 
        deps = { 'kyazdani42/nvim-web-devicons' },
        opts = { theme = 'palenight' },
        lazy = false
    },
    { 
        'nvim-telescope/telescope.nvim', 
        deps = { 'nvim-lua/plenary.nvim' },
        keys = {
            { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Telescope find files' },
            { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Telescope help tags' }
        },
        config = function()
            require('telescope').setup()
        end
    },
    { 
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'md' }
    },
    {
        'norcalli/nvim-colorizer.lua',
        event = 'BufReadPre',
        config = function()
            require('colorizer').setup()
        end
    },
    {
        'tpope/vim-abolish',
        event = 'BufReadPre'
    },
    {
        'hrsh7th/nvim-cmp',
        deps = { 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
        event = 'BufReadPre',
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered()
                },
                sources = cmp.config.sources({
                    { name = 'luasnip' }
                })
            }) 
        end
    }
}
