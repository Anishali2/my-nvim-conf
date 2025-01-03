require("core.options")
require("core.autocmds")
require("core.keymaps")

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
	--
	require("plugins.neotree"),
	require("plugins.vscode-theme"),
	require("plugins.folder-icons"),
	-- require("plugins.auto-save"),
	require("plugins.scroll-bar"),
	require("plugins.tabout"),
	-- require("plugins.colortheme"),
	require("plugins.flash"),
	require("plugins.copilot"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.lsp"),
	-- require("plugins.nvimcap"),
	--
	require("plugins.snippets.luasnip"),
	-- require("plugins.autocompletion"),
	--
	require("plugins.command"),
	require("plugins.autoformatting"),
	require("plugins.gitsigns"),
	require("plugins.alpha"),
	require("plugins.indent-blankline"),
	require("plugins.small-plugins"),
	require("plugins.auto-close-tag"),
	require("plugins.git-lens"),
	require("plugins.fold-ufo"),
	require("plugins.path-auto-complete-new"),
	{
		"piersolenski/telescope-import.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("import")
		end,
	},
-- This lush plugin is used for color schemes 
	{
		"rktjmp/lush.nvim",
	},
-- This nvim-gomove plugin is used for moving lines
-- useage is <leader>g

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
-- This copilot-lualine plugin is used for the status line of copilot
	{
		"AndreM222/copilot-lualine",
	},

})
-- Set up the telescope-myimport plugin
-- require("telescope").setup({})
-- require("telescope").load_extension("myimport")
-- require("core.snippets")
