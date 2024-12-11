return {
	-- nvim-cmp setup
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-path", -- Path completion source
			"hrsh7th/cmp-nvim-lsp", -- LSP completion source
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{ name = "path" }, -- Enable file path auto-completion
					{ name = "nvim_lsp" }, -- LSP-based completion
					-- Add other sources as needed
				},
			})
		end,
	},
}
