return {
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
        'norcalli/nvim-colorizer.lua',
        event = 'BufReadPre',
        config = function()
            require('colorizer').setup()
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
    }
}
