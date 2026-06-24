return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Telescope find files' },
            { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Telescope help tags' },
            { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Telescope live grep' }
        },
        config = function()
        end
    },
    {
        'yorickpeterse/nvim-window',
        keys = {
            { '<leader>w', '<cmd>lua require("nvim-window").pick()<cr>', desc = 'nvim-window' }
        },
        config = true
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },

        config = function()
            local harpoon = require('harpoon')
            harpoon:setup({})

            local conf = require("telescope.config").values
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

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<leader>l", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>t", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>n", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<leader>s", function() harpoon:list():select(4) end)
        end
    }
}
