local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local previewers = require("telescope.previewers")
local Path = require("plenary.path")

-- Define the custom highlight group for the search term
vim.api.nvim_set_hl(0, "TelescopeRedHighlight", { fg = "red", bold = true })

-- Predefined imports for popular libraries
local default_imports = {
  react = {
    { name = "React", path = "react" },
    { name = "{ useState }", path = "react" },
    { name = "{ useEffect }", path = "react" },
    { name = "{ useContext }", path = "react" },
  },
  formik = {
    { name = "Formik", path = "formik" },
    { name = "{ useFormik }", path = "formik" },
  },
  lodash = {
    { name = "{ debounce }", path = "lodash" },
    { name = "{ throttle }", path = "lodash" },
  },
  ["react-router-dom"] = {
    { name = "BrowserRouter", path = "react-router-dom" },
    { name = "{ Link }", path = "react-router-dom" },
    { name = "{ useHistory }", path = "react-router-dom" },
  },
}

-- Helper: Get Libraries from package.json
local function get_libraries_from_package_json()
  local package_json_path = Path:new(vim.loop.cwd() .. "/package.json")

  if not package_json_path:exists() then
    vim.notify("No package.json found in the project root. Skipping library imports.", vim.log.levels.WARN)
    return {}
  end

  local package_json = package_json_path:read()
  local parsed = vim.fn.json_decode(package_json)

  local dependencies = parsed.dependencies or {}
  local devDependencies = parsed.devDependencies or {}

  local libraries = vim.tbl_keys(dependencies)
  vim.list_extend(libraries, vim.tbl_keys(devDependencies))

  return libraries
end

-- Helper: Filter Default Imports Based on Installed Libraries
local function get_filtered_library_imports()
  local libraries = get_libraries_from_package_json()
  local filtered_imports = {}

  for _, library in ipairs(libraries) do
    if default_imports[library] then
      vim.list_extend(filtered_imports, default_imports[library])
    end
  end

  return filtered_imports
end

-- Helper: Calculate relative path
local function get_relative_path(current_file, target_file)
  local current_parts = vim.split(Path:new(current_file):parent():absolute(), Path.path.sep)
  local target_parts = vim.split(Path:new(target_file):absolute(), Path.path.sep)

  local common_index = 1
  while current_parts[common_index] and target_parts[common_index] and
        current_parts[common_index] == target_parts[common_index] do
    common_index = common_index + 1
  end

  local back_steps = #current_parts - common_index + 1
  local relative_parts = {}

  for _ = 1, back_steps do
    table.insert(relative_parts, "..")
  end

  for i = common_index, #target_parts do
    table.insert(relative_parts, target_parts[i])
  end

  local relative_path = table.concat(relative_parts, "/")
  if back_steps == 0 then
    relative_path = "./" .. relative_path
  end

  return relative_path
end

-- Helper: Insert the import statement
local function insert_import(entry)
  local current_buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
  local import_line = nil

  for i, line in ipairs(lines) do
    if line:match("^import") then
      import_line = i
    end
  end

  local path = entry.path
  local component = entry.name
  local import_statement

  if entry.code and entry.code:match("export%s+default") then
    import_statement = string.format('import %s from "%s";', component, path)
  else
    import_statement = string.format('import %s from "%s";', component, path)
  end

  if import_line then
    table.insert(lines, import_line + 1, import_statement)
  else
    table.insert(lines, 1, import_statement)
  end

  vim.api.nvim_buf_set_lines(current_buf, 0, -1, false, lines)
end

-- Parse results
local function parse_results(results, current_file, search_term)
  local exports = {}
  for _, line in ipairs(results) do
    local full_path, code = line:match("^(.-):(.*)$")
    local path = full_path:match("^(.-):?%d*$")

    if path and code then
      local exported_name = code:match("export%s+default%s+function%s+([%w_]+)")
        or code:match("export%s+[%w_]+%s+([%w_]+)")
        or code:match("export%s+default%s+([%w_]+)")
      if exported_name and (not search_term or exported_name:find(search_term, 1, true)) then
        local relative_path = get_relative_path(current_file, path)
        table.insert(exports, { path = relative_path, name = exported_name, code = code, abs_path = path })
      end
    end
  end
  return exports
end

-- Picker logic
local function search_components(opts)
  opts = opts or {}
  local current_file = vim.api.nvim_buf_get_name(0)
  local search_term = opts.search_term or ""

  -- Get Project Exports
  local results = vim.fn.systemlist(
    "rg --no-heading --line-number --color never '^export\\s+(const|let|function|default)'"
  )
  local project_exports = parse_results(results, current_file, search_term)

  -- Get Filtered Library Imports
  local library_imports = get_filtered_library_imports()

  -- Combine Project and Library Imports
  local exports = vim.tbl_extend("force", project_exports, library_imports)

  if #exports == 0 then
    vim.notify("No exports or library imports found!", vim.log.levels.WARN)
    return
  end

  -- Display the Picker
  pickers.new(opts, {
    prompt_title = "Search Imports",
    finder = finders.new_table({
      results = exports,
      entry_maker = function(entry)
        local display
        if entry.is_library then
          display = string.format("import %s from '%s'", entry.name, entry.path)
        else
          display = string.format("import %s from '%s'", entry.name, entry.path)
        end
        return {
          value = entry,
          display = display,
          ordinal = entry.name .. " " .. entry.path, -- Include path for better filtering
        }
      end,
    }),
    previewer = previewers.new_buffer_previewer({
      define_preview = function(self, entry)
        if entry.value.is_library then
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
            "Library Import:",
            string.format("import %s from '%s';", entry.value.name, entry.value.path),
          })
        else
          local absolute_path = Path:new(entry.value.abs_path or entry.value.path):absolute()
          conf.buffer_previewer_maker(absolute_path, self.state.bufnr, {
            bufname = self.state.bufname,
          })
        end
      end,
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      map("i", "<CR>", function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry then
          insert_import(entry.value)
        end
      end)

      map("n", "<CR>", function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry then
          insert_import(entry.value)
        end
      end)

      return true
    end,
  }):find()
end

-- Register the Telescope extension
return telescope.register_extension({
  exports = { myimport = search_components },
})

