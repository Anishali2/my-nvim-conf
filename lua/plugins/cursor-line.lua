-- ~/.config/nvim/lua/plugins/cursorline.lua
return {
  {
    "yamatsum/nvim-cursorline",
    config = function()
      require("nvim-cursorline").setup {
        cursorline = {
          enable = true,         -- Highlight the entire line under the cursor
          timeout = 1000,        -- Timeout for line highlight
          number = false,        -- Highlight the line number
        },
        cursorword = {
          enable = true,         -- Highlight the word under the cursor
          min_length = 3,        -- Minimum length for word highlight
          hl = {                 -- Highlight group
            underline = true,
            bg = "#2e3440",      -- Optional background color
          },
        },
      }
    end,
  },
}

