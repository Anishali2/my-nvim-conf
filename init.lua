-- Require all core file
require("core.options")
require("core.autocmds")
require("core.keymaps")

-- Functions
local toggle = require("functions.toggle_true_false")
vim.api.nvim_set_keymap(
	"n",
	"<leader>tt",
	"<cmd>lua require'functions.toggle_true_false'.toggle_true_false()<CR>",
	{ noremap = true, silent = true, desc = "Toggle `true` | `false`" }
)

local insert_console_log = require("functions.insert_console_log")
vim.api.nvim_set_keymap(
	"n",
	"<leader>cl",
	"<cmd>lua require'functions.insert_console_log'.insert_console_log()<CR>",
	{ noremap = true, silent = true, desc = "console.log('name','value')" }
)

local add_use_client = require("functions.add_use_client")
vim.api.nvim_set_keymap(
	"n",
	"<leader>ta",
	"<cmd>lua require'functions.add_use_client'.add_use_client()<CR>",
	{ noremap = true, silent = true, desc = "Add `use client` on top" }
)

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
	-- require("plugins.bufferline"), -- Tabs bar
	require("plugins.barbar"), -- Tabs bar
	require("plugins.lualine"), -- Bottom Line
	require("plugins.alpha"), -- ASCII Code Image
	require("plugins.indent-blankline"), -- Editor Space Line <Tab>
	require("plugins.command"), -- Floating Cmd Line
	require("plugins.autoformatting"),
	require("plugins.auto-close-tag"),
	require("plugins.fold-ufo"),
	--require("plugins.cursorline"),
	{ "RRethy/vim-illuminate" }, -- Add underline across all related words.
	{ "rktjmp/lush.nvim" },
	-- {
	-- "AndreM222/copilot-lualine",
	-- },

	-- {
	-- "echasnovski/mini.icons",
	-- opts = {},
	-- lazy = true,
	--     },
	-- 'DaikyXendo/nvim-material-icon',
	-- require("plugins.folder-icons"),
	-- require("plugins.auto-save"),

	--------------------------------------------

	-- LSP & Auto-Completion
	require("plugins.lsp"),
	require("plugins.snippets.luasnip"),
	require("plugins.path-auto-complete-new"),
	--require("plugins.lsp-new"),
	require("plugins.session"),
	require("plugins.which-key"),
	-- require("plugins.copilot"),
	require("plugins.codium"),
	--------------------------------------------

	-- Git & GitLens
	require("plugins.gitsigns"),
	require("plugins.git-lens"),

	--------------------------------------------

	-- Tools
	require("plugins.telescope"),
	require("plugins.toggleterm"),
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
require("custom.icons")

require("functions.cursor-style")
-- LSP Toggle State

vim.keymap.set({ "n", "i" }, "<C-u>", function()
	if vim.api.nvim_get_mode().mode == "i" then
		-- Exit insert mode using the stopinsert command
		vim.cmd("stopinsert")
	end

	-- Move to the next diagnostic
	vim.diagnostic.goto_next()

	-- Move to the end of the diagnostic and enter insert mode
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("ea", true, false, true), "n", true)

	-- Trigger completion after a slight delay
	vim.defer_fn(function()
		require("cmp").complete()
	end, 10)
end, { noremap = true, silent = true })

local lazy = require("lazy")

vim.keymap.set("n", "<leader>pt", function()
	local plugin_name = "Exafunction/codeium.vim" -- Ensure this matches the name in lazy.nvim
	local plugins = lazy.plugins() -- Get all loaded plugins
	print(vim.inspect(plugins))
	local plugin = nil
	for _, p in ipairs(plugins) do
		if p.name == plugin_name then
			plugin = p
			break
		end
	end

	if not plugin then
		print("Plugin not found: " .. plugin_name)
		return
	end

	-- Check if plugin is enabled
	if plugin._ and plugin._.installed then
		lazy.disable(plugin_name)
		print("Plugin disabled: " .. plugin_name)
	else
		lazy.enable(plugin_name)
		print("Plugin enabled: " .. plugin_name)
	end
end, { desc = "Toggle Codeium plugin" })
