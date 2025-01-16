-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})
local function toggle_true_false()
  local current_word = vim.fn.expand("<cword>")
  if current_word == "true" then
    vim.cmd('normal! ciwfalse')
  elseif current_word == "false" then
    vim.cmd('normal! ciwtrue')
  end
end

-- Map the function to a keybinding
vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>lua toggle_true_false()<CR>', { noremap = true, silent = true })
-- Jump to the last edit location when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.cmd('normal! g`"')
        end
    end,
})
