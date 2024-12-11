return {
  'akinsho/bufferline.nvim',
  dependencies = {
    'moll/vim-bbye',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers', -- set to "tabs" to only show tabpages instead
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        numbers = 'none', -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
        buffer_close_icon = '✗',
        close_icon = '✗',
        path_components = 1, -- Show only the file name without the directory
        modified_icon = '●',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 21,
        diagnostics = false,
        diagnostics_update_in_insert = false,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = { '│', '│' }, -- | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        show_tab_indicators = false,
        indicator = {
          -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'none', -- Options: 'icon', 'underline', 'none'
        },
        icon_pinned = '󰐃',
        minimum_padding = 1,
        maximum_padding = 5,
        maximum_length = 15,
        sort_by = 'insert_at_end',
      },
      highlights = {
          fill = {
            bg = '#22252c', -- Background color for the whole bufferline bar
          },
          background = {
            bg = '#22252c', -- Background for unselected tabs
            fg = '#D8DEE9', -- Text color for unselected tabs
          },
          buffer_selected = {
            bg = '#434C5E', -- Highlight background for the selected tab
            fg = '#ECEFF4', -- Text color for the selected tab
            bold = true,
            italic = false,
          },
          separator = {
            fg = '#4C566A', -- Separator color
            bg = '#22252c', -- Match bar background
          },
          separator_selected = {
            fg = '#4C566A', -- Separator for selected tab
            bg = '#434C5E', -- Match selected tab background
          },
          close_button = {
            fg = '#BF616A', -- Color of the close button
            bg = '#22252c', -- Add background to prevent transparency
          },
          close_button_selected = {
            fg = '#BF616A', -- Color of the close button for the selected tab
            bg = '#434C5E', -- Match selected tab background
          },
        }
   }
  end,
}
