local icons = require("custom.icons")

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		{ "echasnovski/mini.icons", opts = {} }, -- add mini.icons

		 
		-- {
		-- 	"DaikyXendo/nvim-material-icon",
		-- 	lazy = false,
		-- 	priority = 1000,
		-- 	config = function()
		-- 		local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
		-- 		local material_icons_ok, material_icons = pcall(require, "nvim-material-icons")
		--
		-- 		 if web_devicons_ok and material_icons_ok then
		-- 			web_devicons.setup({
		-- 				override = material_icons.get_icons()
		-- 			})
		-- 		end
		-- 	end
		-- },
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		{
			"s1n7ax/nvim-window-picker",
			version = "2.*",
			config = function()
				require("window-picker").setup({
					filter_rules = {

						include_current_win = true,
						autoselect_one = true,
						-- filter using buffer options
						bo = {
							-- if the file type is one of following, the window will be ignored
							filetype = { "neo-tree", "neo-tree-popup", "notify" },
							-- if the buffer type is one of following, the window will be ignored
							buftype = { "terminal", "quickfix" },
						},
					},
				})
			end,
		},
	},
	config = function()
		-- If you want icons for diagnostic errors, you'll need to define them somewhere:
		vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

		require("neo-tree").setup({
			close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
			sort_case_insensitive = false, -- used when sorting files and directories in the tree
			sort_function = nil, -- use a custom function for sorting files and directories in the tree
			-- sort_function = function (a,b)
			--       if a.type == b.type then
			--           return a.path > b.path
			--       else
			--           return a.type > b.type
			--       end
			--   end , -- this sorts files and directories descendantly
			default_component_configs = {
			icon = {
				    provider = function(icon, node)
				      local text, hl
				      local web_devicons = require("nvim-web-devicons")
				      
				      -- Custom icon definitions
				      local custom_icons = {
					-- Closed folders
					dir = {
					  ["src"] = { text = "󱂵", hl = "Src" },
					  [".git"] = { text = "󰊤", hl = "Git" },
                                          ["app"] = { text = "󰲂", hl = "App" },
					  ["hooks"] = { text = "󱋣", hl = "Hooks" },
					  ["api"] = { text = "󰉐", hl = "Api" },
					  ["settings"] = { text = "󱁿", hl = "Settings" },
					  ["node_modules"] = { text = "", hl = "Node_modules" },
					  ["public"] = { text = "󰉏", hl = "Public" },
					  ["components"] = { text = "󰣞", hl = "Components" },
					  ["assets"] = { text = "󰚝", hl = "Assets" },
					  ["types"] = { text = "", hl = "Types" },
					  ["utils"] = { text = "", hl = "Utils" },
					  ["pages"] = { text = "󰴉", hl = "Pages" },
					  ["providers"] = { text = "", hl = "Providers" },
					  ["svg"] = { text = "󰴉", hl = "Svg" },
					  ["fonts"] = { text = "", hl = "Fonts" },
					  ["test"] = { text = "", hl = "Test" },
					  ["home"] = { text = "󰴉", hl = "Home" },
					  ["store"] = { text = "󰛫", hl = "Store" },
					  ["state"] = { text = "󰛫", hl = "State" },
					  ["auth"] = { text = "󰉐", hl = "Auth" },
					  ["login"] = { text = "󰉐", hl = "Login" },
					  ["languages"] = { text = "󱉭", hl = "Languages" },
					  default = { text = "", hl = "WebDirectoryIcon" }  -- Default closed folder
					},
					-- Open folders
					dir_open = {
					  ["src"] = { text = "", hl = "Src" },
					  ["app"] = { text = "", hl = "App" },
					  [".git"] = { text = "", hl = "Git" },
					  ["hooks"] = { text = "", hl = "Hooks" },
					  ["api"] = { text = "", hl = "Api" },
					  ["settings"] = { text = "", hl = "Settings" },
					  ["node_modules"] = { text = "", hl = "Node_modules" },
					  ["public"] = { text = "", hl = "Public" },
					  ["components"] = { text = "", hl = "Components" },
					  ["assets"] = { text = "", hl = "Assets" },
					  ["types"] = { text = "", hl = "Types" },
					  ["utils"] = { text = "", hl = "Utils" },
					  ["pages"] = { text = "", hl = "Pages" },
					  ["providers"] = { text = "", hl = "Providers" },
					  ["svg"] = { text = "", hl = "Svg" },
					  ["fonts"] = { text = "", hl = "Fonts" },
					  ["test"] = { text = "", hl = "Test" },
					  ["home"] = { text = "", hl = "Home" },
					  ["store"] = { text = "", hl = "Store" },
					  ["state"] = { text = "", hl = "State" },
					  ["auth"] = { text = "", hl = "Auth" },
					  ["login"] = { text = "", hl = "Login" },
					  ["languages"] = { text = "", hl = "Languages" },
					  default = { text = "", hl = "WebDirectoryOpenIcon" }  -- Default open folder
					}
				      }

				      if node.type == "file" then
					-- Regular file icons
					text, hl = web_devicons.get_icon(node.name, nil, { default = true })
				      elseif node.type == "directory" then
					-- Handle folder icons
					local folder_type = node:is_expanded() and "dir_open" or "dir"
					local folder_name = node.name
					
					-- Get custom icon or fallback to default
					local icon_def = custom_icons[folder_type][folder_name] or custom_icons[folder_type].default
					
					text = icon_def.text
					hl = icon_def.hl
					
					-- Special case: Use web-devicons for non-special folders when available
					if folder_name ~= "src" then
					  local web_icon, web_hl = web_devicons.get_icon_by_filetype("directory", { default = false })
					  if web_icon then
					    text = web_icon
					    hl = web_hl
					  end
					end
				      end

				      icon.text = text or " "
				      icon.highlight = hl or "Normal"
				    end,
				  },				-- ... other configurations
			  },
			-- A list of functions, each representing a global custom command
			-- that will be available in all sources (if not overridden in `opts[source_name].commands`)
			-- see `:h neo-tree-custom-commands-global`
			commands = {},
			window = {
				position = "left",
				width = 40,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["<space>"] = {
						"toggle_node",
						nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
					},
					["<2-LeftMouse>"] = "open",
					-- ["<cr>"] = "open",
					["<cr>"] = "open",
						
					["<esc>"] = "cancel", -- close preview or floating neo-tree window
					["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					-- Read `# Preview Mode` for more information
					["l"] = "focus_preview",
					["S"] = "open_split",
					["w"] = "open_vsplit",
					-- ["S"] = "split_with_window_picker",
					-- ["s"] = "vsplit_with_window_picker",
					["t"] = "open_tabnew",
					-- ["<cr>"] = "open_drop",
					-- ["t"] = "open_tab_drop",
					["s"] = "open",
					--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
					["e"] = "close_node",
					["<Esc>[1;5c"] = "close_node",
					-- ['C'] = 'close_all_subnodes',
					["z"] = "close_all_nodes",
					["Z"] = "expand_all_nodes",
					["a"] = {
						"add",
						-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
						-- some commands may take optional config options, see `:h neo-tree-mappings` for details
						config = {
							show_path = "none", -- "none", "relative", "absolute"
						},
					},
					["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
					-- ["c"] = {
					--  "copy",
					--  config = {
					--    show_path = "none" -- "none", "relative", "absolute"
					--  }
					--}
					["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
					["i"] = "show_file_details",
				},
			},
			nesting_rules = {},
			hightlight = {
				enable = true,
				current_file = "NeoTreeFileNameOpened",

			},
			filesystem = {
				filtered_items = {
					visible = false, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_hidden = false, -- only works on Windows for hidden files/directories
					hide_by_name = {
						--"node_modules"
					},
					hide_by_pattern = { -- uses glob style patterns
						--"*.meta",
						--"*/src/*/tsconfig.json",
					},
					always_show = { -- remains visible even if other settings would normally hide it
						--".gitignored",
					    ".env",
						".env.local",
					},
					always_show_by_pattern = { -- uses glob style patterns
						--".env*",
					},
					never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
						--".DS_Store",
						--"thumbs.db"
					},
					never_show_by_pattern = { -- uses glob style patterns
						--".null-ls_*",
					},
				},
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--               -- the current file is changed while the tree is open.
					leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
				group_empty_dirs = false, -- when true, empty folders will be grouped together
				hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
				-- in whatever position is specified in window.position
				-- "open_current",  -- netrw disabled, opening a directory opens within the
				-- window like netrw would, regardless of window.position
				-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
				use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
				-- instead of relying on nvim autocmd events.
				window = {
					mappings = {
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["D"] = "fuzzy_finder_directory",
						["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
						-- ["D"] = "fuzzy_sorter_directory",
						["f"] = "filter_on_submit",
						["<c-x>"] = "clear_filter",
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["og"] = { "order_by_git_status", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
						-- ['<key>'] = function(state) ... end,
					},
					fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
						["<down>"] = "move_cursor_down",
						["<C-n>"] = "move_cursor_down",
						["<up>"] = "move_cursor_up",
						["<C-p>"] = "move_cursor_up",
						-- ['<key>'] = function(state, scroll_padding) ... end,
					},
				},

				commands = {}, -- Add a custom command or override a global one using the same function name
			},
			buffers = {
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--              -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
				group_empty_dirs = true, -- when true, empty folders will be grouped together
				show_unloaded = true,
				window = {
					mappings = {
						["bd"] = "buffer_delete",
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
			},
			git_status = {
				window = {
					position = "float",
					mappings = {
						["<CR>"] = "open",
						["A"] = "git_add_all",
						["s"] = "open",
						["gu"] = "git_unstage_file",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["gc"] = "git_commit",
						["gp"] = "git_push",
						["gg"] = "git_commit_and_push",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
			},
		})
		vim.api.nvim_set_hl(0, "WebDirectoryIcon", { fg = "#a7a9be" })  -- Normal folder color
		vim.api.nvim_set_hl(0, "WebDirectoryOpenIcon", { fg = "#a7a9be" })  -- Open folder color
		vim.api.nvim_set_hl(0, "Src", { fg = "#ff8906" }) 
		vim.api.nvim_set_hl(0, "Auth", { fg = "#ff8906" }) 
		vim.api.nvim_set_hl(0, "Login", { fg = "#ff8906" }) 
		vim.api.nvim_set_hl(0, "App", { fg = "#e53170" }) 
		vim.api.nvim_set_hl(0, "Hooks", { fg = "#a7a9be" }) 
		vim.api.nvim_set_hl(0, "Api", { fg = "#f25f4c" }) 
		vim.api.nvim_set_hl(0, "Settings", { fg = "#7f5af0" }) 
		vim.api.nvim_set_hl(0, "Node_modules", { fg = "#2cb67d" }) 
		vim.api.nvim_set_hl(0, "Public", { fg = "#ff5470" }) 
		vim.api.nvim_set_hl(0, "Assets", { fg = "#8c7851" }) 
		vim.api.nvim_set_hl(0, "Types", { fg = "#fec7d7" }) 
		vim.api.nvim_set_hl(0, "Utils", { fg = "#a7a9be" }) 
		vim.api.nvim_set_hl(0, "Pages", { fg = "#a786df" }) 
		vim.api.nvim_set_hl(0, "Components", { fg = "#fde24f" }) 
		vim.api.nvim_set_hl(0, "Providers", { fg = "#2cb67d" }) 
		vim.api.nvim_set_hl(0, "Svg", { fg = "#475d5b" }) 
		vim.api.nvim_set_hl(0, "Fonts", { fg = "#f2f7f5" }) 
		vim.api.nvim_set_hl(0, "Git", { fg = "#f2f7f5" }) 
		vim.api.nvim_set_hl(0, "Test", { fg = "#3da9fc" }) 
		vim.api.nvim_set_hl(0, "Home", { fg = "#094067" }) 
		vim.api.nvim_set_hl(0, "Store", { fg = "#90b4ce" }) 
		vim.api.nvim_set_hl(0, "State", { fg = "#272343" }) 
		vim.api.nvim_set_hl(0, "Languages", { fg = "#bae8e8" }) 
		vim.keymap.set("n", "<leader>e", ":Neotree toggle position=left<CR>", { noremap = true, silent = true })
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				-- Only open if no files were explicitly specified
				if #vim.fn.argv() == 0 then
					vim.cmd("Neotree position=left")
				end
			end,
		})
	end,
}
