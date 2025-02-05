
local M = {}
function M.add_use_client()
  -- Save the current cursor position
  local current_pos = vim.api.nvim_win_get_cursor(0)

  -- Add "use client" at the top of the file
  vim.api.nvim_buf_set_lines(0, 0, 0, false, { '"use client"' })

  -- Restore the cursor position
  vim.api.nvim_win_set_cursor(0, { current_pos[1] + 1, current_pos[2] })
end
return M
