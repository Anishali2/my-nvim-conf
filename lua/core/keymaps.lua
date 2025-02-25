-- Set leader key		  
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<leader>u", vim.lsp.buf.definition, { desc = "Go to Definition" })
-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> silent w! <CR>", opts)

vim.keymap.set("i", "<C-s>", "<cmd> silent w! <CR>", opts)
-- save file without auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts)

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>x", ":bdelete!<CR>", opts) -- close buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)
-- Navigate between splits in insert mode
vim.keymap.set("i", "<C-k>", "<Esc>:wincmd k<CR>", opts)
vim.keymap.set("i", "<C-j>", "<Esc>:wincmd j<CR>", opts)
vim.keymap.set("i", "<C-h>", "<Esc>:wincmd h<CR>", opts)
vim.keymap.set("i", "<C-l>", "<Esc>:wincmd l<CR>", opts)
-- Tabs
vim.keymap.set("n", "<leader>to", ":BufferCloseAllButCurrent<CR>", opts) -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab
-- Close all tabs except the current one
vim.keymap.set("n", "<leader>tc", ":tabonly<CR>", opts)

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)
-- use f7 key to switch between normal mode and insert mode only use one button
vim.keymap.set("n", "<F7>", "<cmd>startinsert<CR>", opts)
vim.keymap.set("i", "<F7>", "<cmd>stopinsert<CR>", opts)
-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Go to next diagnostics and move the cursor to the end of the word
-- vim.keymap.set("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>ea<C-Space>", opts)
-- Fold Configure
-- vim.keymap.set("n", "zR", require("ufo").openAllFolds)
-- vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

vim.api.nvim_set_keymap("n", "<leader>i", "<cmd>Telescope myimport<CR>", opts)
-- In your keymap configuration:
local map = vim.api.nvim_set_keymap


-- Normal mode: Toggle comment on the current line with Ctrl+/
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>") -- move line up(n)
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>") -- move line down(n)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

vim.keymap.set("n", "'", "diw")

vim.keymap.set(
	"n", -- Normal mode
	"<C-p>", -- Ctrl+Shift+P
	"<cmd>Telescope oldfiles<CR>", -- Directly run the 'Search Recent Files' Telescope command
	opts
)
vim.keymap.set(
	"i", -- Normal mode
	"<C-p>", -- Ctrl+Shift+P
	"<cmd>Telescope oldfiles<CR>", -- Directly run the 'Search Recent Files' Telescope command
	opts
)
vim.keymap.set("n", ":", "<cmd>FineCmdline<CR>", opts)
-- press ctrl + / to execute vim "gcc" command
vim.keymap.set("n", "<C-_>", "gcc", opts)
vim.keymap.set("v", "<C-_>", "gcc", opts)
vim.keymap.set("i", "<C-_>", "gcc", opts)

vim.keymap.set("i", "<C-e>", function()
	vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-x><C-o>", true, true, true), "n")
end, { desc = "Trigger LSP Completion" })
vim.api.nvim_set_keymap('n', '<C-A>', 'ggVG', opts)
vim.api.nvim_set_keymap('i', '<C-A>', '<cmd>stopinsert<CR>ggVG', opts)
-- Copy to clipboard
vim.api.nvim_set_keymap('n', '<C-c>', '"+y', opts)
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', opts)

-- Paste from clipboard
vim.api.nvim_set_keymap('n', '<C-v>', '"+gP', opts)
vim.api.nvim_set_keymap('i', '<C-v>', '<C-r>+', opts)

vim.api.nvim_set_keymap('n', '<C-x>', '"+d', opts)
vim.api.nvim_set_keymap('v', '<C-x>', '"+d', opts)

-- Undo (Ctrl+Z)
vim.api.nvim_set_keymap('n', '<C-z>', 'u', opts)
vim.api.nvim_set_keymap('i', '<C-z>', '<C-o>u', opts)

-- Redo (Ctrl+Shift+Z)
vim.api.nvim_set_keymap('n', '<C-S-z>', '<C-r>', opts)
vim.api.nvim_set_keymap('i', '<C-S-z>', '<C-o><C-r>', opts)


-- Use Telescope Buffers 
vim.api.nvim_set_keymap('n', '<leader>sb', '<cmd>Telescope buffers<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>rr', ':source $MYVIMRC<CR>:Lazy reload<CR>', { noremap = true, silent = true })

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


vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })


vim.keymap.set("n", "<leader>gs", ":Neotree reveal git_status<CR>", { noremap = true, silent = true })

-- Search for whole word only
vim.keymap.set("n", "g/", "/\\<\\><Left><Left>", opts)         -- Search for whole words only
-- Ctrl + Shift + k to close <cmd>qa!<CR>
vim.keymap.set("n", "<C-S-k>", "<cmd>qa!<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-S-k>", "<cmd>qa!<CR>", { noremap = true, silent = true })




-- ~/.config/nvim/lua/plugins.lua
return {
    {
        "nvim-tree/nvim-tree.lua",
        enabled = false, -- Disable by default
        config = function()
            require("nvim-tree").setup({
                -- Your nvim-tree configuration here
            })
        end,
    },
}

-- ~/.config/nvim/lua/config/keymaps.lua












