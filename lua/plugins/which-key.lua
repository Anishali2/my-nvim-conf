return {
  -- Hints keybinds
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      keys = {
        -- Use `keys` instead of `popup_mappings`
        scroll_down = '<PageDown>',
        scroll_up = '<PageUp>',
      },
      defer = {
        gc = "Comments", -- Use `defer` instead of `operators`
      },
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
    })
  end,
}

