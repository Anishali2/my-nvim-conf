local ok, luasnip = pcall(require, "luasnip")
if not ok then
  vim.notify("LuaSnip not found! Please install it.", vim.log.levels.ERROR)
  return
end

-- Define the reusable hookcomp snippet
local hookcomp_snippet = luasnip.snippet("hookcomp", {
  luasnip.text_node("export default function "),
  luasnip.insert_node(1, "Component"),
  luasnip.text_node("() {"),
  luasnip.text_node("  const ["),
  luasnip.insert_node(2, "state"),
  luasnip.text_node(", set"),
  luasnip.dynamic_node(3, function(args)
    return luasnip.snippet_node(nil, {
      luasnip.text_node(args[1][1]:gsub("^%l", string.upper)), -- Capitalize the first letter of the second cursor word
    })
  end, { 2 }),
  luasnip.text_node("] = useState("),
  luasnip.insert_node(4, ""),
  luasnip.text_node(");"),
  luasnip.text_node("  "),  -- Adds some spacing for readability
  luasnip.insert_node(0),    -- Last cursor position
  luasnip.text_node(""),
  luasnip.text_node("}"),
})

-- Register the snippet for multiple filetypes
luasnip.add_snippets("javascript", { hookcomp_snippet })
luasnip.add_snippets("typescriptreact", { hookcomp_snippet })

return luasnip
: