return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 20,
      open_mapping = [[<leader>tf]], -- Toggle terminal with <leader>tf
      direction = "float",
      float_opts = {
        border = "curved",
        width = 120,
        height = 30,
      },
      -- Start in insert mode when the terminal opens
      on_open = function(term)
        vim.cmd("startinsert") -- Force insert mode on open
      end,
      -- Keymaps to close terminal with <Esc>
      on_create = function(term)
        -- Exit terminal mode and close with <Esc> in terminal mode
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n><cmd>close<cr>]], { buffer = term.bufnr, noremap = true, silent = true })
        -- Close from normal mode (fallback)
        vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = term.bufnr, noremap = true, silent = true })
      end,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Optional: Ensure terminal closes cleanly
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "toggleterm",
        callback = function()
          vim.cmd("checktime") -- Refresh buffers if needed
        end,
      })
    end,
  },
}
