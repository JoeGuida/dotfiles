return{
    {
        'catppuccin/nvim',
        lazy = false
    },
    {
        'sainnhe/everforest',
        lazy = false,
        config = function()
            vim.g.everforest_background = 'dark'
        end
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<CR>'] = cmp.mapping.confirm({ selct = true })
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'luasnip' }
                }),
            })
        end     
    },
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('lspconfig').clangd.setup {
                cmd = { 'clangd', '--background-index' },
                filetypes = { 'c', 'cpp' },
                capabilities = require('cmp_nvim_lsp').default_capabilities()
            }
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
        lazy = false,
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
        'stevearc/oil.nvim',
        lazy = false,
        config = function()
	    require('oil').setup()
        end
    }
}
