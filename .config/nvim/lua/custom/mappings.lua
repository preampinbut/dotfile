---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["gl"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
    ["<M-j>"] = { ":m .+1<CR>", "move line up" },
    ["<M-k>"] = { ":m .-2<CR>", "move line up" },
    ["<leader>q"] = { ":q<CR>", "quit" },
  },
  v = {
    [">"] = { ">gv", "indent" },
    ["<M-j>"] = { ":m '>+1<CR>gv", "move line up" },
    ["<M-k>"] = { ":m '<-2<CR>gv", "move line up" },
  },
}

-- more keybinds!
M.lspconfig = {
  n = {
    ["<leader>lk"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["<leader>lj"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },
  },
}

return M
