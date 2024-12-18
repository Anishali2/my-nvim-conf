return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		-- adds function arg help while typing out functions!!!
		"hrsh7th/cmp-nvim-lsp-signature-help",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local luasnip = require("luasnip")

			luasnip.add_snippets("markdown", require("snippets.notes"))
			luasnip.add_snippets("text", require("snippets.notes"))
			luasnip.add_snippets("tex", require("snippets.latex"))
			-- Set up nvim-cmp.
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup({
				preselect = cmp.PreselectMode.None,
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-8>"] = cmp.mapping.complete(), -- Trigger completion
					["<C-e>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.close() -- Close the menu if it's open
						else
							cmp.complete() -- Open the menu if it's not open
						end
					end, { "i", "c" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "emmet_ls" },
				},
				experimental = {
					ghost_text = true, -- Show a preview of the completion
				},
			})
		end,
	},
}
