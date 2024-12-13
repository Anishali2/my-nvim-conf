return {
	-- Add copilot.lua
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true, -- Enable inline suggestions
					events = {
						triggered = function()
							update_copilot_status("loading")
						end,
						accepted = function()
							update_copilot_status("ready")
						end,
						rejected = function()
							update_copilot_status("ready")
						end,
					},
					auto_trigger = true, -- Auto-trigger suggestions
					keymap = {
						accept = "<Tab>", -- Map Ctrl+L to accept suggestions
						next = "<C-]>",
						prev = "<C-[>",
						dismiss = "<C-\\>",
					},
				},
				panel = {
					enabled = true, -- Enable Copilot's side panel
				},
			})
		end,
	},
}
