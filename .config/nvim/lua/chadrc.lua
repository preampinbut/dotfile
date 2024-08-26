-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  transparency = true,

  hl_override = {
    Comment = { italic = false },
    ["@comment"] = { italic = false },
  },
  hl_add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
  },
}

M.ui = {
  nvdash = {
    header = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    },
    load_on_startup = true,
  },

  tabufline = {
    lazyload = true,
    order = {
      "treeOffset",
      "mbuffers",
      "tabs",
      -- "mbtns",
    },
    modules = {
      mbuffers = function()
        local buffers = require("configs.tabufline.modules").buffers
        return buffers()
      end,
      mbtns = function()
        local btns = require("configs.tabufline.modules").btns
        return btns()
      end,
    },
  },

  statusline = {
    theme = "default",
    separator_style = "block",
  },
}

return M
