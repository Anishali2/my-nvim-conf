local M = {}

function M.resolve_diagnostics()

 local diagnostics = vim.diagnostic.get(0)

    -- Sort diagnostics by line number
    table.sort(diagnostics, function(a, b)
        return a.lnum < b.lnum
    end)

    -- Find the next diagnostic after the current cursor position
    local current_line, current_col = unpack(vim.api.nvim_win_get_cursor(0))
    for _, diagnostic in ipairs(diagnostics) do
        if diagnostic.lnum > current_line - 1 or (diagnostic.lnum == current_line - 1 and diagnostic.col > current_col) then
            -- Move the cursor to the start of the diagnostic
            vim.api.nvim_win_set_cursor(0, {diagnostic.lnum + 1, diagnostic.col})

            -- Move the cursor to the end of the word
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("e", true, false, true), 'n', true)

            -- Switch to Insert mode
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("a", true, false, true), 'n', true)

            -- Trigger the LSP dropdown (Ctrl + Space)
            -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-Space>", true, false, true), 'n', true)
            return
        end
    end

    -- Notify if no more diagnostics are found
    vim.notify("No more diagnostics found!", vim.log.levels.INFO)

    
end
return M
-- Map the function to a keybinding
