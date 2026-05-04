return {
    {
        'casedami/neomodern.nvim',
        config = function()
            require("neomodern").setup({
              bg = "default",
              theme = "hojicha",

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
