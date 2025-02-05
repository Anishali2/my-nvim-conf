return {
  {
    "Exafunction/codeium.vim", -- Codeium plugin
    config = function()
      -- Disable default keybindings (optional)
      vim.g.codeium_disable_bindings = 1

      -- Set up custom keybindings
      vim.keymap.set("i", "<Tab>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })

      vim.keymap.set("i", "<C-]>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })

      vim.keymap.set("i", "<M-]>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })

      vim.keymap.set("i", "<M-[>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })

      -- Enable Codeium for specific filetypes (optional)
      vim.g.codeium_filetypes = {
        python = true,
        lua = true,
        javascript = true,
        typescript = true,
        -- Add other filetypes as needed
      }

      -- Enable Codeium by default (optional)
      vim.g.codeium_enabled = true
    end,
  },
}