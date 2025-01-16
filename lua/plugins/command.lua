return {
	"VonHeikemen/fine-cmdline.nvim",
	decs = "Floating command line",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		cmdline = {
			prompt = "❯ ",
			default_value = "",
			border = {
				style = "rounded",
				text = {
					top = " Command ",
				},
			},
		},
		popup = {
			position = {
				row = "50%",
				col = "50%",
			},
			size = {
				width = "50%",
			},
			border = {
				style = "rounded",
			},
			relative = "editor", -- Ensure it spans the entire editor, not the active window
			win_options = {
				winblend = 0, -- Fully opaque for static background
				cursorline = true, -- Highlight the cursor line for better visibility
			},
		},
	},
	keymaps = {
		-- Keybindings for history navigation
		["<C-k>"] = function()
			local prev = get_previous_command()
			if prev then
				return prev
			end
		end,
		["<C-j>"] = function()
			return get_next_command()
		end,
	},
}
