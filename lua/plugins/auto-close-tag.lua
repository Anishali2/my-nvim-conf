return {
	-- Ensure you have treesitter installed and configured
	{
	  'nvim-treesitter/nvim-treesitter',
	  build = ':TSUpdate',  -- makes sure parsers are up to date
	  config = function()
		require('nvim-treesitter.configs').setup {
		  -- Add any languages you need here
		  ensure_installed = { "html", "javascript", "typescript", "tsx", "lua" },
		  highlight = { enable = true },
		}
	  end
	},
  
	-- nvim-ts-autotag for auto-closing tags
	{
	  'windwp/nvim-ts-autotag',
	  dependencies = { 'nvim-treesitter/nvim-treesitter' },
	  config = function()
		require('nvim-ts-autotag').setup()
	  end
	},
  
	-- tagalong.vim for updating closing tags automatically
	{
	  'AndrewRadev/tagalong.vim',
	  config = function()
		-- No config needed by default, just works out-of-the-box
		-- You can add custom filetypes if needed:
		-- vim.g.tagalong_additional_filetypes = { "typescriptreact", "javascriptreact" }
	  end
	}
  }
  