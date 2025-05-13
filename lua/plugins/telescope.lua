return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      "nvim-telescope/telescope-media-files.nvim",
      config = function()
        require("telescope").load_extension("media_files")
      end
    },
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    -- { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
    
      --  All the info you're looking for is in `:help telescope.setup()`
      extensions = {
         media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "gif"}
            filetypes = { "png", "webp", "jpg", "jpeg","svg" },
            find_cmd = "rg", -- find command (defaults to `fd`)
            backend = "ueberzugpp", -- Enable proper preview

          }
      },
      defaults = {
        winblend = 15, -- Adjust this value (0-100) for desired transparency
        mappings = {
          i = {
            ['<C-3>'] = require('telescope.actions.layout').toggle_preview,
            ['<C-k>'] = require('telescope.actions').move_selection_previous, -- move to prev result
            ['<C-j>'] = require('telescope.actions').move_selection_next, -- move to next result
            ['<C-l>'] = require('telescope.actions').select_default, -- open file
            ["<Esc>"] = require('telescope.actions').close, -- Bind ESC to close in Insert mode
          },
          n = {
            ['<leader>gn'] = require('telescope.actions.layout').toggle_preview,
            ["<Esc>"] = require('telescope.actions').close, -- Bind ESC to close in Normal mode
          },
        },
      },
      pickers = {
        find_files = {
          file_ignore_patterns = { 'node_modules','.next','.git', '.venv' },
          hidden = true,
          cache = true
        },
      },
      live_grep = {
        file_ignore_patterns = { 'node_modules', '.git', '.venv','package-lock.json','.next','yarn.lock','pnpm-lock.yaml'},
        additional_args = function(_)
          return { '--hidden' }
        end,
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'media_files')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>si', builtin.git_status, { desc = '[G]it [S]tatus (staged/unstaged files)' })
    -- Search for files text in github staged and unstaged
vim.keymap.set("n", "<leader>so", function()
  -- Get staged, unstaged, and untracked files (same as git_status)
  local cmd = "git -c core.quotePath= status -s --porcelain -u | awk '{print $2}'"
  local ok, files = pcall(vim.fn.systemlist, cmd)
  
  if not ok or vim.v.shell_error ~= 0 then
    vim.notify("Error fetching Git files. Not in a repository?", vim.log.levels.ERROR)
    return
  end
  if #files == 0 then
    vim.notify("No modified or untracked files found.", vim.log.levels.WARN)
    return
  end

  -- Pass files explicitly to rg via "--" argument
  require('telescope.builtin').live_grep({
    additional_args = function()
      return { "--", unpack(files) }  -- "-- file1 file2 file3..."
    end
  })
end, { desc = "[S]earch [O]pen Git staged/unstaged files" })
    vim.keymap.set('n', '<leader>sy', ":lua require('telescope.builtin').git_files({ additional_args = { '--fixed-strings' }})<CR>", { desc = '[G]it [F]iles' })
    -- vim.keymap.set('n', '<leader>sz', ":lua require('telescope.builtin').help_tags({ additional_args = { '--fixed-strings' }})<CR>", { desc = '[S]earch [H]elp' })
    -- vim.keymap.set('n', '<leader>sk', ":lua require('telescope.builtin').keymaps({ additional_args = { '--fixed-strings' }})<CR>", { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', ":lua require('telescope.builtin').find_files({ additional_args = { '--fixed-strings' }})<CR>", { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>st', ":lua require('telescope.builtin').find_files({ additional_args = { '--fixed-strings','--ignore-case' }})<CR>", { desc = '[S]earch [F]iles [A]ny [C]ase' })
    vim.keymap.set('n', '<leader>ss', ":lua require('telescope.builtin').builtin({ additional_args = { '--fixed-strings' }})<CR>", { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', ":lua require('telescope.builtin').grep_string({ additional_args = { '--fixed-strings' }})<CR>", { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', ":lua require('telescope.builtin').live_grep({ additional_args = { '--fixed-strings','--ignore-case' }})<CR>", { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sh', ":lua require('telescope.builtin').live_grep({ additional_args = { '--fixed-strings' }})<CR>", { desc = '[S]earch by [G]rep [W]ithout [C]ase' })
    vim.keymap.set('n', '<leader>sd', ":lua require('telescope.builtin').diagnostics({ additional_args = { '--fixed-strings' }})<CR>", { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', ":lua require('telescope.builtin').resume({ additional_args = { '--fixed-strings' }})<CR>", { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', ":lua require('telescope.builtin').oldfiles({ additional_args = { '--fixed-strings' }})<CR>", { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', ":lua require('telescope.builtin').buffers({ additional_args = { '--fixed-strings' }})<CR>", { desc = '[ ] Find existing buffers' })
    vim.api.nvim_set_keymap('n','<leader>gd',':Telescope lsp_definitions<CR>',{ noremap = true, silent = true })
    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 15,
        previewer = false,
        border = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })
  end,
}
