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
        lazy = false,
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
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        opts = { theme = 'palenight' },
        lazy = false
    },
    { 
        'nvim-telescope/telescope.nvim', 
        lazy = false,
        dependencies = { 'nvim-lua/plenary.nvim' },
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
    },
    {
        'kalvinpearce/ShaderHighlight',
        event = 'BufReadPre',
        config = function()
        end
    },
    {
        'ThePrimeagen/harpoon',
        lazy = false,
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local harpoon = require('harpoon')
            harpoon:setup({})

            vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
            vim.keymap.set('n', '<leader>c', function() harpoon:list():clear() end)
            vim.keymap.set('n', '<C-f>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set('n', '<C-h>', function() harpoon:list():select(1) end)
            vim.keymap.set('n', '<C-t>', function() harpoon:list():select(2) end)
            vim.keymap.set('n', '<C-n>', function() harpoon:list():select(3) end)
            vim.keymap.set('n', '<C-s>', function() harpoon:list():select(4) end)
            vim.keymap.set('n', '<C-S-P>', function() harpoon:list():prev() end)
            vim.keymap.set('n', '<C-S-N>', function() harpoon:list():next() end)

            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()
            end
        end
    }
}
