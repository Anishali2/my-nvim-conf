local M = {}  -- Module table

local ns = vim.api.nvim_create_namespace('underlined_words')

-- Highlight all occurrences of the word under the cursor
function M.setup()
  -- Define underline style
  vim.api.nvim_set_hl(0, 'UnderlinedWord', {
    underline = true,
    sp = '#FF0000',  -- Red underline
  })

  -- Update highlights on cursor hold/movement
  vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI', 'TextChanged', 'TextChangedI'}, {
    callback = function()
      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
      local word = vim.fn.expand('<cword>')
      if word == '' then return end

      local escaped_word = vim.fn.escape(word, '\\/.*$^~[]')
      for lnum, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
        local start_idx = 1
        while true do
          local start_pos, end_pos = line:find(escaped_word, start_idx, true)
          if not start_pos then break end
          vim.api.nvim_buf_add_highlight(0, ns, 'UnderlinedWord', lnum - 1, start_pos - 1, end_pos)
          start_idx = end_pos + 1
        end
      end
    end,
  })
end

return M
