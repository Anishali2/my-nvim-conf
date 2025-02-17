-- LSP Toggle State
local lsp_enabled = true

local function toggle_lsp()
  lsp_enabled = not lsp_enabled
  if lsp_enabled then
    vim.notify("LSP Enabled")
    vim.cmd([[LspStart]])
    vim.diagnostic.enable()
  else
    vim.notify("LSP Disabled")
    vim.cmd([[LspStop]])
    vim.diagnostic.disable()
  end
end

-- Keymap
vim.api.nvim_set_keymap("n", "<C-Space>", "<cmd>lua toggle_lsp()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-Space>", "<cmd>lua toggle_lsp()<CR>", { noremap = true, silent = true })
