return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    on_attach = function(client, bufnr)
      -- Only attach to specific file types
      local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
      if not vim.tbl_contains({ "javascript", "typescript", "javascriptreact", "typescriptreact" }, filetype) then
        vim.notify("Skipping LSP attachment for " .. filetype)
        client.stop()
        return
      end
      
      -- Your existing on_attach logic here
    end,
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  }
}
