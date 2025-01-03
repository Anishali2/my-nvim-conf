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
		  luasnip.lsp_expand(args.body)
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
		  },
		},
	  }),
	  formatting = {
		fields = { "abbr", "kind", "menu" },
		format = function(entry, vim_item)
		  if entry.source.name == "nvim_lsp" then
			-- Default menu fallback
			vim_item.menu = "[LSP]"
	  
			-- Attempt to extract `moduleSpecifier` from `entryNames`
			local data = entry.completion_item.data
			if data and data.entryNames and data.entryNames[1] and data.entryNames[1].data then
			  local moduleSpecifier = data.entryNames[1].data.moduleSpecifier
			  if moduleSpecifier then
				vim_item.menu = moduleSpecifier -- Show the module path in the `menu`
			  end
			end
		  elseif entry.source.name == "buffer" then
			vim_item.menu = "[Buffer]"
		  elseif entry.source.name == "path" then
			vim_item.menu = "[Path]"
		  else
			vim_item.menu = "[" .. entry.source.name .. "]"
		  end
	  
		  -- Return the modified completion item
		  return vim_item
		end,
	  }, 
	  mapping = {
		["<C-n>"] = cmp.mapping(function(fallback)
		  if cmp.visible() then
			cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
		  else
			fallback() -- Use default behavior if completion menu is not visible
		  end
		end, { "i", "c" }), -- `i` for insert mode, `c` for command-line mode
	  
		["<C-p>"] = cmp.mapping(function(fallback)
		  if cmp.visible() then
			cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
		  else
			fallback() -- Use default behavior if completion menu is not visible
		  end
		end, { "i", "c" }), -- `i` for insert mode, `c` for command-line mode
	  
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm the currently selected item
		["<C-Space>"] = cmp.mapping.complete(),           -- Trigger completion manually
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
