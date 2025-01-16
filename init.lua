-- Require all core file					
require("core.options")
require("core.autocmds")
require("core.keymaps")

-- Functions 
local toggle = require("functions.toggle_true_false")
vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>lua require'functions.toggle_true_false'.toggle_true_false()<CR>", { noremap = true, silent = true, desc = "Toggle `true` | `false`"  })


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
	-- UI & Appearance
	require("plugins.vscode-theme"), -- VS-Code theme
	require("plugins.scroll-bar"), -- Scroll Bar
	require("plugins.bufferline"), -- Tabs bar
	require("plugins.lualine"), -- Bottom Line
	require("plugins.alpha"), -- ASCII Code Image
	require("plugins.indent-blankline"), -- Editor Space Line <Tab> 
	require("plugins.command"), -- Floating Cmd Line
	require("plugins.autoformatting"),
	require("plugins.auto-close-tag"),
	require("plugins.fold-ufo"),
	{       "rktjmp/lush.nvim"},
	{
	"AndreM222/copilot-lualine",
	},
	-- {
	-- "echasnovski/mini.icons",
	-- opts = {},
	-- lazy = true,
    --     },

        -- require("plugins.folder-icons"),
	-- require("plugins.auto-save"),
	
	--------------------------------------------
	
	-- LSP & Auto-Completion
	require("plugins.lsp"),
	require("plugins.snippets.luasnip"),
	require("plugins.path-auto-complete-new"),
	require("plugins.which-key"),
	
        --------------------------------------------
	
        -- Git & GitLens
	require("plugins.gitsigns"),
	require("plugins.git-lens"),
        
	--------------------------------------------
	
	-- Tools
	require("plugins.telescope"),
	require("plugins.copilot"),
	require("plugins.flash"),
	require("plugins.treesitter"),
	require("plugins.neotree"),
	require("plugins.small-plugins"),
	require("plugins.line-move"),
	-- require("plugins.tabout"),
	-- require("plugins.colortheme"),
	-- require("plugins.nvimcap"),
	-- require("plugins.autocompletion"),
	
	{
		"piersolenski/telescope-import.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("import")
		end,
	},
	{
		"nvim-web-devicons",
		priority = 99999900000,
		config = function()
		  require("nvim-web-devicons").set_icon({
			src = {
			  icon = "",
			  color = "#FF0000",
			  name = "SrcFolder",
			},
			node_modules = {
			  icon = "",
			  color = "#00FF00",
			  name = "NodeModules",
			},
		  })
		end,
	  },

})

-- Set up the telescope-myimport plugin
-- require("telescope").setup({})
-- require("telescope").load_extension("myimport")
-- require("core.snippets")

require("functions.cursor-style")


















