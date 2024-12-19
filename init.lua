require("core.options")
require("core.autocmds")
require("core.keymaps")
require("core.snippets")
-- require("core.command")
-- Set up the Lazy plugin manager

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)
-- Set up plugins
require("lazy").setup({
	require("plugins.neotree"),
	require("plugins.tabout"),
	require("plugins.colortheme"),
	require("plugins.flash"),
	require("plugins.copilot"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.lsp"),
	require("plugins.snippets.luasnip"),
	require("plugins.command"),
	require("plugins.autocompletion"),
	require("plugins.autoformatting"),
	require("plugins.gitsigns"),
	require("plugins.alpha"),
	require("plugins.indent-blankline"),
	require("plugins.small-plugins"),
	require("plugins.auto-close-tag"),
	require("plugins.git-lens"),
	require("plugins.fold-ufo"),
	require("plugins.path-auto-complete"),
	{
		"piersolenski/telescope-import.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("import")
		end,
	},

	{
		"rktjmp/lush.nvim",
	},
	{
		"booperlv/nvim-gomove",
		priority = 10000,
		config = function()
			require("gomove").setup({
				-- Optional configuration
				map_defaults = true, -- Use default key mappings
				reindent = true, -- Reindent when moving lines
				undojoin = true, -- Undo block after movement
				move_past_end_col = false, -- Don't move past end of line
			})
		end,
	},
	{
		"AndreM222/copilot-lualine",
	},
	-- {
	-- 	"my-telescope-plugin",
	-- 	dir = vim.fn.stdpath("config") .. "/lua/telescope-myimport/init.lua", -- Define custom plugin directory
	-- 	config = function()
	-- 	  -- Ensure your custom extension is available
	-- 	  require("telescope").load_extension("myimport")
	-- 	end,
	--   },
})
-- Set up the telescope-myimport plugin
require("telescope").setup({})
require("telescope").load_extension("myimport")