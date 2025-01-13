return {
  -- Hints keybinds
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      keys = {
        scroll_down = '<PageDown>',
        scroll_up = '<PageUp>',
      },
    })
  end,
}

