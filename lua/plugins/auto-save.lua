-- File: lua/plugins/autosave.lua
return {
  {
    "pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enabled = true, -- Auto-save starts active
        execution_message = {
          message = function() -- Custom message when saving
            return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
          end,
          dim = 0.18,
          cleaning_interval = 1250,
        },
        trigger_events = { "TextChanged", "TextChangedI" }, -- Triggers on text change in normal and insert mode
        condition = function(buf)
          local fn = vim.fn
          local utils = require("auto-save.utils.data")

          -- Check if the buffer is modifiable and not of excluded filetypes
          if
            fn.getbufvar(buf, "&modifiable") == 1
            and utils.not_in(fn.getbufvar(buf, "&filetype"), { "lazy", "TelescopePrompt" })
          then
            return true
          end
          return false
        end,
        write_all_buffers = false, -- Save only the current buffer
        debounce_delay = 135, -- Small delay before writing buffer to disk
        callbacks = {
          before_saving = function()
            -- Logic to execute before saving, if needed
          end,
          after_saving = function()
            -- Logic to execute after saving, if needed
          end,
        },
      })
    end,
  },
}

