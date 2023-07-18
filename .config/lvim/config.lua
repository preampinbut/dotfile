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

-- Save all
lvim.builtin.which_key.mappings.W = {
  "<cmd>:wa<cr>", "Save All"
}

-- Terminal mode to return to normal
vim.api.nvim_set_keymap('t', '<C-\\><C-n>', "<C-\\><C-n><cr>",
  { noremap = true, silent = true })

lvim.colorscheme = "dracula"

lvim.builtin.treesitter.ensure_installed = "all"

lvim.plugins = {
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "ray-x/starry.nvim",
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
require("plugins.tree")
require("plugins.telescope")
require("plugins.comment")
require("plugins.fold")
