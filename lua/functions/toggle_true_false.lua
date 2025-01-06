local M = {}

function M.toggle_true_false()
  local current_word = vim.fn.expand("<cword>")
  if current_word == "true" then
    vim.cmd('normal! ciwfalse')
  elseif current_word == "false" then
    vim.cmd('normal! ciwtrue')
  end
end

return M


