-- Example structure for your nvim-cmp plugin spec
return {
  "hrsh7th/nvim-cmp",
  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip") -- Keep if using luasnip

    -- Extend LuaSnip for React filetypes (Keep this if needed)
    luasnip.filetype_extend("javascript", { "javascriptreact" })
    luasnip.filetype_extend("typescript", { "typescriptreact" })

    -- NOTE: All lspconfig setup, custom source code (parse_ts_file, custom_source, register_source),
    --       and requires for plenary are REMOVED from here.

    return {
      -- Keep your existing sections for:
      completion = {
          autocomplete = {
            cmp.TriggerEvent.TextChanged,
            cmp.TriggerEvent.InsertEnter,
          },
         completeopt = "menu,menuone,noselect,noinsert",
         keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
         keyword_length = 2,
         throttle = 50,  -- You might adjust these later if needed
         debounce = 150, -- You might adjust these later if needed
      },
      preselect = cmp.PreselectMode.None,
      performance = {
        async_budget = 2, -- Consider increasing this (e.g., 4 or higher) if needed *after* removing the custom source
        max_view_entries = 15,
        fetching_timeout = 250,
        debounce = 250,
        throttle = 150,
        confirm_resolve_timeout = 50,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        -- REMOVED: { name = "typescript_custom", ... }
        { name = "nvim_lsp", priority = 1000, max_item_count = 20 },
        { name = "luasnip", priority = 750, max_item_count = 10 },
        { name = "path", priority = 500, max_item_count = 10 },
        -- Consider adding { name = "buffer", priority = 250 } for buffer word completions
      }),
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
          -- You might need to adjust this if you remove sources
           if entry.source.name == "nvim_lsp" then
             vim_item.menu = "[LSP]"
           elseif entry.source.name == "luasnip" then
             vim_item.menu = "[Snippet]"
           elseif entry.source.name == "buffer" then
             vim_item.menu = "[Buffer]"
           elseif entry.source.name == "path" then
             vim_item.menu = "[Path]"
           else
             vim_item.menu = "[" .. entry.source.name .. "]"
           end
          return vim_item
        end,
      },
      mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<Tab>"] = cmp.mapping(function(fallback)
             if cmp.visible() then
               cmp.select_next_item()
             elseif luasnip.expand_or_jumpable() then
               luasnip.expand_or_jump()
             else
               fallback()
             end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
             if cmp.visible() then
               cmp.select_prev_item()
             elseif luasnip.jumpable(-1) then
               luasnip.jump(-1)
             else
               fallback()
             end
          end, { "i", "s" }),
         -- Your <leader>tq mapping - REMOVED the autocmd definition from here
          ["<leader>tq"] = cmp.mapping(function()
              vim.diagnostic.goto_next()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("e", true, false, true), 'n', true)
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("a", true, false, true), 'n', true)
              cmp.complete()
          end, { "n" }),
      },
      experimental = {
        ghost_text = false,
      },
    }
  end,
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer", -- Add if you want buffer completions
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    -- "nvim-lua/plenary.nvim", -- Remove if not needed by other parts of the config
  },
  event = { "InsertEnter" },
  cmd = "CmpStatus",
}
