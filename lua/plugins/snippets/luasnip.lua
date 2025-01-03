return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local d = ls.dynamic_node
        local sn = ls.snippet_node
        local fmt = require("luasnip.extras.fmt").fmt

        ls.config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
            store_selection_keys = "<Tab>",
        })

        require("luasnip.loaders.from_vscode").lazy_load()
    end
}