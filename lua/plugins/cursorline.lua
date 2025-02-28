return {
	'yamatsum/nvim-cursorline',
	config = function()
		require('nvim-cursorline').setup({
			cursorword = {
				enable = true, -- Highlight the word under the cursor
				min_length = 3, -- Minimum length for word highlight
			},
		})
	end
}
