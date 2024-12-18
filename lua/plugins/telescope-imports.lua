return {
	"piersolenski/telescope-import.nvim",
	dependencies = "nvim-telescope/telescope.nvim",
	config = function()
		require("telescope").setup({
			extensions = {
				import = {
					-- Customize for React projects
					custom_languages = {
						{
							-- Support for JavaScript and TypeScript React files
							extensions = { "js", "jsx", "ts", "tsx" },
							filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
							-- Enhanced regex to capture both import types
							regex = [[^(?:import\s*(?:(?:[\w*{}\s]+)\s*from\s*)?[\'"](.+)[\'"].*|export\s*(?:default\s*)?(?:const|function|class|let|var)\s*([\w]+))]],
							-- Optional: Insert at top of file
							insert_at_top = true,
						},
					},
				},
			},
		})

		-- Load the extension
		require("telescope").load_extension("import")
	end,
}
