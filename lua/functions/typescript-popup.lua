-- Hover with Delay
local hover_timer = nil

local function show_type_hover()
  if hover_timer then
    hover_timer:close()
  end
  
  hover_timer = vim.defer_fn(function()
    if vim.lsp.buf.server_ready() then
      vim.lsp.buf.hover()
    end
    hover_timer = nil
  end, 2000) -- 2 second delay
end

-- Clear timer on cursor move
vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
  pattern = {"*.js", "*.ts", "*.jsx", "*.tsx"},
  callback = function()
    if hover_timer then
      hover_timer:close()
      hover_timer = nil
    end
  end
})

-- Keymap for manual hover
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

-- Auto-hover configuration
vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
  pattern = {"*.js", "*.ts", "*.jsx", "*.tsx"},
  callback = function()
    if lsp_enabled then
      show_type_hover()
    end
  end
})

-- Configure hover appearance
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded",
    focusable = false,
    max_width = 80,
    silent = true
  }
)
