M = {}

M.setup = function()
  local harpoon = require "harpoon"
  harpoon:setup()
  harpoon:extend {
    UI_CREATE = function(cx)
      vim.keymap.set("n", "l", function()
        harpoon.ui:select_menu_item()
      end, { buffer = cx.bufnr })
    end,
  }
end

return M
