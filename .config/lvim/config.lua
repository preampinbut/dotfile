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

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldenable = true
vim.cmd [[
augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* mkview
    " autocmd BufWinEnter *.* silent! loadview
augroup END
]]

function Mkview_if_no_view()
  local view_file = vim.fn.expand('%:p') .. '.view'
  if vim.fn.filereadable(view_file) == 0 then
    vim.cmd('mkview')
  else
    print('View file already exists.')
  end
end

vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      callback = function()
        vim.defer_fn(function()
          local str = vim.api.nvim_replace_termcodes("<cmd>lua Mkview_if_no_view()<cr>:silent! loadview<cr>", true, false,
            true)
          vim.api.nvim_feedkeys(str, "m", false)
        end, 60)
      end,
    })
  end,
})

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
