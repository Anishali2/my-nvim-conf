return {
	'hrsh7th/nvim-cmp',
	dependencies = {
	  'hrsh7th/cmp-nvim-lsp',
	  'hrsh7th/cmp-buffer',
	  'hrsh7th/cmp-path',
	  'L3MON4D3/LuaSnip',
	  'saadparwaiz1/cmp_luasnip'
	},
	config = function()
	  local cmp = require('cmp')
	  local luasnip = require('luasnip')
  
	  cmp.setup({
		snippet = {
		  expand = function(args)
			luasnip.lsp_expand(args.body)
		  end,
		},
		mapping = cmp.mapping.preset.insert({
		  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
		  ['<C-f>'] = cmp.mapping.scroll_docs(4),
		  ['<C-Space>'] = cmp.mapping.complete(),
		  ['<C-e>'] = cmp.mapping.abort(),
		  ['<CR>'] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
		  { name = 'nvim_lsp' },
		  { name = 'luasnip' },
		}, {
		  { name = 'buffer' },
		  { name = 'path' },
		}),
		formatting = {
			format = function(entry, vim_item)
			  local completion_item = entry:get_completion_item()
			  
			  if entry.source.name == "buffer" then
				-- For buffer completions, we know the buffer number and can get its path
				local buffer_path = vim.api.nvim_buf_get_name(entry.context.bufnr)
				if buffer_path and buffer_path ~= "" then
				  -- Make the path relative to the project root or home directory
				  buffer_path = vim.fn.fnamemodify(buffer_path, ":~:.")
				  vim_item.menu = "[Buffer: " .. buffer_path .. "]"
				else
				  vim_item.menu = "[Buffer]"
				end
			  elseif entry.source.name == "nvim_lsp" then
				-- For LSP completions, try using the 'detail' field of the completion item.
				-- The TypeScript LS often puts module or file info here.
				if completion_item.detail and completion_item.detail ~= "" then
				  vim_item.menu = completion_item.detail
				else
				  vim_item.menu = "[LSP]"
				end
			  elseif entry.source.name == "luasnip" then
				vim_item.menu = "[Snippet]"
			  elseif entry.source.name == "path" then
				vim_item.menu = "[Path]"
			  else
				vim_item.menu = "[" .. entry.source.name .. "]"
			  end
		  
			  return vim_item
			end
		  }
		  ,
	  })
	end
  }
  