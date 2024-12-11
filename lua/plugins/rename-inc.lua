return {
	"smjonas/inc-rename.nvim",
	config = function()
		require("inc_rename").setup({
			-- Optional: Configuration settings for inc-rename
		})
	end,
	keys = {
		{ "<F2>", ":IncRename ", desc = "Rename symbol" }, -- Map F2 to incremental rename
	},
}
