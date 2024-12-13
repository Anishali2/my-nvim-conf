local cmdline_win = nil -- Store the floating window ID
local cmdline_buf = nil -- Store the buffer ID
local command_history = {} -- List to store previously executed commands
local history_index = nil -- Current position in the history for navigation

-- Function to create the floating command line
_G.open_floating_cmdline = function()
  local ui = vim.api.nvim_list_uis()[1]
  local width = math.floor(ui.width * 0.5)
  local height = 1

  local opts = {
    relative = "editor",
    row = math.floor((ui.height - height) / 2),
    col = math.floor((ui.width - width) / 2),
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
  }

  -- Create the floating buffer and window
  cmdline_buf = vim.api.nvim_create_buf(false, true)
  cmdline_win = vim.api.nvim_open_win(cmdline_buf, true, opts)

  -- Set the buffer to accept input and act as a command line
  vim.bo[cmdline_buf].buftype = "prompt"
  vim.cmd("startinsert!") -- Start in insert mode
  vim.fn.prompt_setprompt(cmdline_buf, ":")

  -- Initialize history navigation index
  history_index = #command_history + 1

  -- Handle key mappings
  vim.api.nvim_buf_set_keymap(cmdline_buf, "i", "<CR>", "<Cmd>lua _G.execute_floating_cmdline()<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(cmdline_buf, "i", "<Esc>", "<Cmd>lua _G.close_floating_cmdline()<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(cmdline_buf, "i", "<C-j>", "<Cmd>lua _G.navigate_command_history(1)<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(cmdline_buf, "i", "<C-k>", "<Cmd>lua _G.navigate_command_history(-1)<CR>", { noremap = true, silent = true })
end

-- Function to execute the command entered in the floating buffer
_G.execute_floating_cmdline = function()
  if cmdline_buf and vim.api.nvim_buf_is_valid(cmdline_buf) then
    -- Get the user input from the buffer
    local lines = vim.api.nvim_buf_get_lines(cmdline_buf, 0, -1, false)
    local command = table.concat(lines, " ")

    -- Add the command to history if not empty
    if command ~= "" then
      table.insert(command_history, command)
    end

    -- Close the floating window
    _G.close_floating_cmdline()

    -- Execute the command
    vim.cmd(command)
  end
end

-- Function to navigate the command history
_G.navigate_command_history = function(direction)
  if not cmdline_buf or not vim.api.nvim_buf_is_valid(cmdline_buf) then
    return
  end

  -- Update history index based on direction
  history_index = history_index + direction

  -- Clamp history index between 1 and the number of commands
  if history_index < 1 then
    history_index = 1
  elseif history_index > #command_history then
    history_index = #command_history
  end

  -- Get the command at the current history index
  local command = command_history[history_index] or ""

  -- Replace the content of the floating buffer with the command
  vim.api.nvim_buf_set_lines(cmdline_buf, 0, -1, false, { command })
  vim.api.nvim_win_set_cursor(cmdline_win, { 1, #command }) -- Move cursor to the end
end

-- Function to close the floating command line
_G.close_floating_cmdline = function()
  if cmdline_win and vim.api.nvim_win_is_valid(cmdline_win) then
    vim.api.nvim_win_close(cmdline_win, true)
  end
  cmdline_win = nil
  cmdline_buf = nil
  history_index = nil
end

-- Map ":" in normal mode to open the floating command line
vim.api.nvim_set_keymap("n", ":", "<Cmd>lua _G.open_floating_cmdline()<CR>", { noremap = true, silent = true })

