-- Require all core files
require("core.options")
require("core.autocmds")
require("core.keymaps")

-- Functions 



local toggle = require("functions.toggle_true_false")
vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>lua require'functions.toggle_true_false'.toggle_true_false()<CR>", { noremap = true, silent = true })


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
	require("plugins.vscode-theme"),
	-- require("plugins.folder-icons"),
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
	require("plugins.neotree"),
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

{
	"echasnovski/mini.icons",
		opts = {},
		lazy = true,
	  },
})
-- Set up the telescope-myimport plugin
-- require("telescope").setup({})
-- require("telescope").load_extension("myimport")
-- require("core.snippets")
 vim.opt.guicursor = {
	"n:block-CursorYellow", -- Normal mode: Yellow block
	"i:block-CursorInsert", -- Insert mode: Vertical bar (25% width) with green
	"v:block-CursorBlue", -- Visual mode: Blue block
	"c:ver25", -- Command-line mode: Vertical bar
	"r:hor20", -- Replace mode: Horizontal bar
	"o:block", -- Operator-pending mode: Block cursor
	"a:blinkwait700-blinkon400-blinkoff250", -- Blinking animation for all modes
}

-- Define highlight groups
vim.cmd([[
	highlight CursorYellow guifg=NONE guibg=yellow
	highlight CursorInsert guifg=NONE guibg=white blend=30
	highlight CursorBlue guifg=NONE guibg=blue
	]])
vim.opt.cursorcolumn = true

-- Define highlight color for CursorColumn
vim.cmd [[
  augroup CursorColumnInit
    autocmd!
    autocmd VimEnter * highlight CursorColumn guibg=#2c323c ctermbg=8
  augroup END
]]
