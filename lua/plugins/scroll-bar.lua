return {
    {
        "petertriho/nvim-scrollbar",
        event = "BufReadPost", -- Load the plugin after a buffer is read
        config = function()
            require("scrollbar").setup({
                handle = {
                    color = "#808080", -- Gray background for the scrollbar handle
                },
                marks = {
                    Cursor = {
                        color = "#FFFFFF", -- White border for the scrollbar
                    },
                },
                -- Add other settings if needed
            })
        end,
    },
}
