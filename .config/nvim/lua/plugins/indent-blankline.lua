return {
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      local highlight = {
        "CatppuccinRed",
        "CatppuccinYellow",
        "CatppuccinBlue",
        "CatppuccinOrange",
        "CatppuccinGreen",
        "CatppuccinViolet",
        "CatppuccinCyan",
      }

      local scope_highlight = {
        "CatppuccinPink",
      }

      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "CatppuccinRed", { fg = mocha.red })
        vim.api.nvim_set_hl(0, "CatppuccinYellow", { fg = mocha.yellow })
        vim.api.nvim_set_hl(0, "CatppuccinBlue", { fg = mocha.blue })
        vim.api.nvim_set_hl(0, "CatppuccinOrange", { fg = mocha.peach })
        vim.api.nvim_set_hl(0, "CatppuccinGreen", { fg = mocha.green })
        vim.api.nvim_set_hl(0, "CatppuccinViolet", { fg = mocha.mauve })
        vim.api.nvim_set_hl(0, "CatppuccinCyan", { fg = mocha.sky })
        vim.api.nvim_set_hl(0, "CatppuccinPink", { fg = mocha.pink })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

      return {
        indent = {
          char = "▎",
          tab_char = "▎",
          highlight = highlight,
        },
        scope = {
          enabled = true,
          highlight = scope_highlight,
          show_start = true,
          show_end = true,
          show_exact_scope = false,
        },
      }
    end,
  },
}
