 vim.opt.guicursor = {
	"n:block-CursorYellow", -- Normal mode: Yellow block
	"i:block-CursorInsert", -- Insert mode: Vertical bar (25% width) with green
	"v:block-CursorBlue", -- Visual mode: Blue block
	"c:ver25", -- Command-line mode: Vertical bar
	"r:hor20", -- Replace mode: Horizontal bar
	"o:block", -- Operator-pending mode: Block cursor
	"a:blinkwait700-blinkon400-blinkoff250", -- Blinking animation for all modes
}

-- Define highlight groups
vim.cmd([[
	highlight CursorYellow guifg=NONE guibg=yellow
	highlight CursorInsert guifg=NONE guibg=white blend=30
	highlight CursorBlue guifg=NONE guibg=blue
	]])
vim.opt.cursorcolumn = true

-- Define highlight color for CursorColumn
vim.cmd [[
  augroup CursorColumnInit
    autocmd!
    autocmd VimEnter * highlight CursorColumn guibg=#2c323c ctermbg=8
  augroup END
]]


