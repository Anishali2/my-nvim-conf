return {
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
}
