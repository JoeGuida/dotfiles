return{
    {
        'catppuccin/nvim',
        lazy = false,
        config = function()
        end
    },
    {
        'sainnhe/everforest',
        lazy = false,
        config = function()
        end
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-path'
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
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort()
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'luasnip' },
                    { name = 'path' }
                }),
            })
        end
    },
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
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        opts = { theme = 'palenight' },
        lazy = false
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown', 'md' }
    },
    {
        'norcalli/nvim-colorizer.lua',
        event = 'BufReadPre',
        config = function()
            require('colorizer').setup()
        end
    },
    {
        'kalvinpearce/ShaderHighlight',
        lazy = false,
        config = function()
        end
    },
    {
        'folke/noice.nvim',
        event = VeryLazy,
        dependencies = {
            'MunifTanjim/nui.nvim'
        },
        config = function()
            require('noice').setup({
                lsp = {
                    override = {
                        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                        ['vim.lsp.util.stylize_markdown'] = true,
                        ['cmp.entry.get_documentation'] = true
                    }
                },
                presets = {
                    bottom_search = true,
                    command_palette = false,
                    lsp_doc_border = true
                }
            })
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Telescope find files' },
            { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Telescope help tags' }
        },
        config = function()
        end
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        event = 'VeryLazy',
        config = function()
            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { 'treesitter', 'indent' }
                end
            })
        end
    }
}

