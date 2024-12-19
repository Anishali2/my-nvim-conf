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

  if entry.code:match("export%s+default") then
    import_statement = string.format('import %s from "%s";', component, path)
  else
    import_statement = string.format('import { %s } from "%s";', component, path)
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

  local results = vim.fn.systemlist(
    "rg --no-heading --line-number --color never '^export\\s+(const|let|function|default)'"
  )

  local exports = parse_results(results, current_file, search_term)

  if #exports == 0 then
    vim.notify("No exports found matching your query!", vim.log.levels.WARN)
    return
  end

  -- Syntax Highlighting for Results Pane
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "TelescopeResults",
    callback = function(ctx)
      vim.api.nvim_buf_set_option(ctx.buf, "filetype", "typescript")
    end,
  })

  -- Picker
  pickers.new(opts, {
    prompt_title = "Search Exports",
    finder = finders.new_table({
      results = exports,
      entry_maker = function(entry)
        return {
          value = entry,
          display = string.format("import { %s } from \"%s\";", entry.name, entry.path),
          ordinal = entry.name,
        }
      end,
    }),
    previewer = previewers.new_buffer_previewer({
      define_preview = function(self, entry)
        local absolute_path = Path:new(entry.value.abs_path or entry.value.path):absolute()
        conf.buffer_previewer_maker(absolute_path, self.state.bufnr, {
          bufname = self.state.bufname,
        })

        -- Highlight the search term in the preview
        local search_term = entry.value.name
        vim.api.nvim_buf_call(self.state.bufnr, function()
          vim.fn.matchadd("TelescopeRedHighlight", search_term)
        end)
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
