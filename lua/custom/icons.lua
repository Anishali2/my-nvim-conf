-- ~/.config/nvim/lua/custom/nvim-neo-tree-custom/icons.lua
local M = {}

M.custom_icons = {
    -- Custom folder icons
    src = {
        icon = "", -- Custom icon for "src" folder
        color = "#ffa500", -- Custom color
        cterm_color = "208", -- Terminal color
        name = "SrcFolder", -- Name for the icon
    },
    git = {
        icon = "", -- Custom icon for ".git" folder
        color = "#f14c28", -- Custom color
        cterm_color = "166", -- Terminal color
        name = "GitFolder", -- Name for the icon
    },
    node_modules = {
        icon = "", -- Custom icon for "node_modules" folder
        color = "#cc3534", -- Custom color
        cterm_color = "160", -- Terminal color
        name = "NodeModulesFolder", -- Name for the icon
    },
    -- Add more custom icons here
}

return M
