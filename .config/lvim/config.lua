-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.showcmd = true
vim.opt.scrolloff = 15
vim.opt.hidden = false

lvim.format_on_save = true

-- Buffer navigation
lvim.keys.normal_mode["<Tab>"] = ":bnext<cr>"
lvim.keys.normal_mode["<S-Tab>"] = ":bprev<cr>"

lvim.builtin.which_key.mappings.C = {
  "<cmd>:bufdo bd<cr>", "Close All Buffer"
}

-- BUG: csharp_lsp related colorscheme not load
-- NOTE: <leader>+W This is to fix problem cause by csharp_ls
-- wait for csharp_ls to finish load up project then press <leader>+W
-- its not a big deal just annoying
lvim.builtin.which_key.mappings.W = {
  "<cmd>:w<cr>:mkview<cr>:e<cr>", "Save and Reload"
}

-- Terminal mode to return to normal
vim.api.nvim_set_keymap('t', '<C-\\><C-n>', "<C-\\><C-n><cr>",
  { noremap = true, silent = true })

lvim.builtin.treesitter.ensure_installed = "all"

lvim.colorscheme = "tokyonight-night"

lvim.plugins = {
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require "lsp_signature".setup {
        hint_enable = false
      }
    end
  },
  {
    "ray-x/starry.nvim",
    config = function()
      local starry = require "starry"
      local colors = require "starry.colors"
      starry.setup {
        custom_highlights = {
          BufferLineBackground = {
            bg = colors.bg,
            italic = true
          }
        }
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "<CurrentMajor>.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
}

require("plugins.dap")
require("plugins.lsp")
require("plugins.lualine")
require("plugins.snippet")
require("plugins.signature")
require("plugins.tree")
require("plugins.telescope")
require("plugins.comment")
-- WARN: currently conflict with go to definition
-- require("plugins.fold")
