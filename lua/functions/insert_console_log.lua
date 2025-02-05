local M = {}

function M.insert_console_log()
  local current_word = vim.fn.expand("<cword>")
  vim.cmd('normal! oconsole.log("' .. current_word .. ':", ' .. current_word .. ');')
end

return M

