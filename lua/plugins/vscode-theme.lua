-- File: lua/plugins/theme.lua
return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000, -- Load the theme before other plugins
    config = function()
      require("vscode").setup({
        style = "dark", -- Choose "dark" or "light"
        transparent = false, -- Disable or enable transparent background
        italic_comments = true, -- Italicize comments
      })
      require("vscode").load()
    end,
  },
}

