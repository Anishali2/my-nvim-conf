return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets", -- Predefined snippets
		},
		config = function()
			require("luasnip").setup({
				history = true, -- Keep last snippet active to jump back
				updateevents = "TextChanged,TextChangedI",
			})
			-- Load snippets from friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Add custom JavaScriptReact snippet
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node

			ls.add_snippets("javascriptreact", {
				s("fc", {
					t("function "),
					i(1, "ComponentName"),
					t("() {"),
					t({ "", "  return (" }),
					t({ "", "    <div>" }),
					t({ "", "      " }),
					i(2, "<></>"),
					t({ "", "    </div>" }),
					t({ "", "  );" }),
					t({ "", "}" }),
					t({ "", "" }),
					t("export default "),
					i(1, "ComponentName"),
				}),
			})
		end,
	},
}
