return {
    {
        'catppuccin/nvim',
        lazy = false,
    },
    {
        'sainnhe/everforest',
        lazy = false,
    },
    {
        'casedami/neomodern.nvim',
        config = function()
            require("neomodern").setup({
              bg = "default",
              theme = "moon",

              gutter = {
                cursorline = false,
                dark = false,
              },

              diagnostics = {
                darker = true,
                undercurl = true,
                background = true,
              }
            })

            require("neomodern").load()
        end
    }
}
