return {
  "hrsh7th/nvim-cmp",
  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    luasnip.filetype_extend("javascript", { "javascriptreact" })
    luasnip.filetype_extend("typescript", { "typescriptreact" })

    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      performance = {
        max_view_entries = 20,
        debounce = 150,
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "crates" },
        {
          name = "buffer",
          keyword_length = 4,
          max_item_count = 10,
          option = {
            get_bufnrs = function()
              local buf = vim.api.nvim_get_current_buf()
              local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
              if byte_size > 1024 * 1024 then
                return {}
              end
              return { buf }
            end,
            indexing_interval = 1000,
          },
        },
      }),
      mapping = {
        -- Next item (Ctrl+9)
        ["<C-9>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            cmp.confirm({ select = true })  -- Auto-confirm when moving to next item
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s", "n" }),

        -- Previous item (Ctrl+8)
        ["<C-8>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
            cmp.confirm({ select = true })  -- Auto-confirm when moving to previous item
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s", "n" }),

        -- Manual confirm (Ctrl+0)
        ["<C-0>"] = cmp.mapping({
          i = function()
            if cmp.visible() then
              cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
            else
              cmp.complete()
            end
          end,
          n = function()
            if cmp.visible() then
              cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
            else
              cmp.complete()
            end
          end,
        }),

        -- Open completion menu
        ["<C-Space>"] = cmp.mapping(function()
          if not cmp.visible() then
            cmp.complete()
          end
        end, { "i", "n" }),
      },
      experimental = {
        ghost_text = true,
      },
    }
  end,
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  event = { "InsertEnter", "CmdlineEnter" },
  cmd = "CmpStatus",
}