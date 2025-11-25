return {
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<S-tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<A-[>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "<A-]>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = function(_, opts)
      if (vim.g.colors_name or ""):find("catppuccin") then
        opts.highlights = require("catppuccin.special.bufferline").get_theme()
      end

      opts.options.show_buffer_close_icons = false
    end,
  },
}
