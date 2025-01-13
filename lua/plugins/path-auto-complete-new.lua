return {
  "hrsh7th/nvim-cmp",
  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local Path = require("plenary.path")
    local scan = require("plenary.scandir")

    -- Extend LuaSnip for React filetypes
    luasnip.filetype_extend("javascript", { "javascriptreact" })
    luasnip.filetype_extend("typescript", { "typescriptreact" })

    -- Helper function to extract `types`, `interfaces`, and `enums` from a file
    local function parse_ts_file(filepath)
      local results = {}
      local stats = vim.loop.fs_stat(filepath)
      if stats and stats.size > 1024 * 1024 then -- Skip files larger than 1MB
        return results
      end
      
      for line in io.lines(filepath) do
        local type_match = line:match("^%s*export%s+type%s+([%w_]+)")
        local interface_match = line:match("^%s*export%s+interface%s+([%w_]+)")
        local enum_match = line:match("^%s*export%s+enum%s+([%w_]+)")

        if type_match then
          table.insert(results, { kind = "Type", name = type_match, file = filepath })
        end
        if interface_match then
          table.insert(results, { kind = "Interface", name = interface_match, file = filepath })
        end
        if enum_match then
          table.insert(results, { kind = "Enum", name = enum_match, file = filepath })
        end
      end
      return results
    end

    -- Optimized custom source implementation with caching
    local custom_source = {
      cache_time = 5 * 60 * 1000, -- Cache results for 5 minutes
      _cache = {},
      _last_update = {},

      complete = function(self, request, callback)
        local cwd = vim.fn.getcwd()
        
        -- Check cache first
        local cache_key = cwd .. request.context.cursor_before_line
        if self._cache[cache_key] and (os.time() - self._last_update[cache_key] < self.cache_time) then
          callback(self._cache[cache_key])
          return
        end
        
        local items = {}
        
        scan.scan_dir(cwd, {
          search_pattern = "%.tsx?$",
          hidden = true,
          add_dirs = false,
          depth = 5, -- Limit search depth
          filter = function(entry)
            return not entry:match("node_modules")
              and not entry:match("%.git")
              and not entry:match("%.next")
          end,
          on_insert = function(filepath)
            local parsed_items = parse_ts_file(filepath)
            for _, item in ipairs(parsed_items) do
              table.insert(items, {
                label = item.name,
                kind = vim.lsp.protocol.CompletionItemKind[item.kind],
                detail = string.format("[%s] %s", item.kind, item.file),
                documentation = "Custom completion for exported " .. item.kind,
                insertText = item.name,
                additionalTextEdits = {
                  {
                    range = {
                      start = { line = 0, character = 0 },
                      ["end"] = { line = 0, character = 0 },
                    },
                    newText = string.format('import { %s } from "%s";\n', item.name, filepath:match("([^/]+)%.tsx?$")),
                  },
                },
              })
            end
          end,
        })

        -- Cache the results
        self._cache[cache_key] = { items = items, isIncomplete = false }
        self._last_update[cache_key] = os.time()
        
        callback({ items = items, isIncomplete = false })
      end,
    }

    -- Register the custom source
    cmp.register_source("typescript_custom", custom_source)

    -- Combined optimized configuration
    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
        throttle = 50,
        debounce = 150,
      },
      performance = {
        max_view_entries = 20,
        debounce = 150,
        throttle = 50,
        fetching_timeout = 200,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000, max_item_count = 20 },
        { name = "luasnip", priority = 750, max_item_count = 10 },
        { name = "path", priority = 500, max_item_count = 10 },
        { name = "typescript_custom", priority = 250, max_item_count = 15 },
      }),
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
          if entry.source.name == "nvim_lsp" then
            vim_item.menu = "[LSP]"
          elseif entry.source.name == "buffer" then
            vim_item.menu = "[Buffer]"
          elseif entry.source.name == "path" then
            vim_item.menu = "[Path]"
          elseif entry.source.name == "typescript_custom" then
            vim_item.menu = "[TS]"
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
      },
      experimental = {
        ghost_text = false, -- Disabled for performance
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
    "nvim-lua/plenary.nvim",
  },
  event = { "InsertEnter" },
  cmd = "CmpStatus",
}
