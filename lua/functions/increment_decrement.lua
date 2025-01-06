local function increment_number(step)
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")
  local prefix = line:sub(1, col - 1)
  local num = tonumber(line:match("%d+", col))
  local suffix = line:sub(col + 1)

  if num then
    num = num + step
    vim.fn.setline(".", prefix .. num .. suffix)
    vim.fn.cursor(0, col) -- Keep the cursor position
  else
    vim.notify("No number found at the cursor", vim.log.levels.WARN)
  end
end

-- Bindings for Normal Mode
vim.keymap.set("n", "<C-=>", function() increment_number(1) end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-->", function() increment_number(-1) end, { noremap = true, silent = true })

-- Bindings for Insert Mode
vim.keymap.set("i", "<C-=>", function()
  vim.api.nvim_input("<ESC>") -- Exit Insert mode
  increment_number(1)
  vim.api.nvim_input("i") -- Re-enter Insert mode
end, { noremap = true, silent = true })

vim.keymap.set("i", "<C-->", function()
  vim.api.nvim_input("<ESC>") -- Exit Insert mode
  increment_number(-1)
  vim.api.nvim_input("i") -- Re-enter Insert mode
end, { noremap = true, silent = true })
