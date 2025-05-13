local function insert_snippet(snippet)
  vim.cmd('normal! o' .. snippet)
  vim.cmd('startinsert')
end

vim.keymap.set("n", "<leader>ku", function()
  insert_snippet([[
function example() {
}
]])
end, { noremap = true, silent = true })

