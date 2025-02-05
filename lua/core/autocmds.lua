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

local function insert_console_log()
  local current_word = vim.fn.expand("<cword>")
  vim.cmd('normal! oconsole.log("' .. current_word .. ':", ' .. current_word .. ');')
end

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.cmd('normal! g`"')
        end
    end,
})

vim.opt.cmdheight = 0

-- Autocommand to show the command line when entering command mode
vim.api.nvim_create_autocmd("CmdlineEnter", {
  pattern = { ":", "/", "?" },
  callback = function()
    vim.opt.cmdheight = 1 -- Show the command line
  end,
})

-- Autocommand to hide the command line after leaving command mode
vim.api.nvim_create_autocmd("CmdlineLeave", {
  pattern = { ":", "/", "?" },
  callback = function()
    vim.opt.cmdheight = 0 -- Hide the command line
  end,
})
