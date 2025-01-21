return {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
        require("kanagawa").setup({
            transparent = true,
            -- theme = "wave",
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none"
                        }
                    }
                }
            }
        })
        vim.cmd("colorscheme kanagawa-wave")
    end,
}


