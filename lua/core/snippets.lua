local function FunctionalComponentSnippet(args)
	-- Split the arguments by whitespace
	local parts = {}
	for word in args.args:gmatch("%S+") do
		table.insert(parts, word)
	end

	local component_name = parts[1] or "Component"

	local line_num = vim.api.nvim_win_get_cursor(0)[1]

	local lines = {
		"function " .. component_name .. " () {",
		"",
		"return (",
		"   <div>",
		"      <></>",
		"   </div>",
		"  )",
		"}",
		"",
		"export default" .. component_name .. "",
	}

	vim.api.nvim_buf_set_lines(0, line_num, line_num, false, lines)
end

vim.api.nvim_create_user_command("Srafce", FunctionalComponentSnippet, { nargs = "+" })
-- Use State Snippet
local function UseStateSnippet(args)
	local parts = {}
	for word in args.args:gmatch("%S+") do
		table.insert(parts, word)
	end
	local state_name = parts[1] or "Component"
	local value = parts[2] or "Component"
	local line_num = vim.api.nvim_win_get_cursor(0)[1]
	local lines = {
		"const [" .. state_name .. ", set" .. state_name .. "] = useState(" .. value .. ")",
	}

	vim.api.nvim_buf_set_lines(0, line_num, line_num, false, lines)
end

vim.api.nvim_create_user_command("State", UseStateSnippet, { nargs = "+" })
