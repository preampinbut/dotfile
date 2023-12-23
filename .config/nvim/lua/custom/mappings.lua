---@type MappingsTable
local M = {}

M.disabled = {
  t = {
    ["A-i"] = "",
    ["A-h"] = "",
    ["A-v"] = "",
  },
  n = {
    ["<leader>h"] = "",
    ["<leader>v"] = "",
  },
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["gl"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
    ["<M-j>"] = { "<cmd> m .+1<CR>", "move line up" },
    ["<M-k>"] = { "<cmd> m .-2<CR>", "move line up" },
    ["<leader>q"] = { "<cmd> q<CR>", "quit" },
    ["<leader>;"] = { "<cmd> Nvdash<CR>", "open dashboard" },
  },
  v = {
    [">"] = { ">gv", "indent" },
    ["<M-j>"] = { "<cmd> m '>+1<CR>gv", "move line up" },
    ["<M-k>"] = { "<cmd> m '<-2<CR>gv", "move line up" },
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

M.tabufline = {
  n = {
    ["<M-tab>"] = {
      function()
        require("nvchad.tabufline").move_buf(1)
      end,
      "Move buffer right",
    },

    ["<M-S-tab>"] = {
      function()
        require("nvchad.tabufline").move_buf(-1)
      end,
      "Move buffer left",
    },
  },
}

M.harpoon = {
  n = {
    ["<leader>ha"] = {
      "<cmd> lua require('harpoon'):list():append() <CR>",
      "Append",
    },
    ["<leader>hl"] = {
      "<cmd> lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) <CR>",
      "Toggle quick menu",
    },

    ["<M-1>"] = {
      "<cmd> lua require('harpoon'):list():select(1) <CR>",
      "Select 1",
    },
    ["<M-2>"] = {
      "<cmd> lua require('harpoon'):list():select(2) <CR>",
      "Select 2",
    },
    ["<M-3>"] = {
      "<cmd> lua require('harpoon'):list():select(3) <CR>",
      "Select 3",
    },
    ["<M-4>"] = {
      "<cmd> lua require('harpoon'):list():select(4) <CR>",
      "Select 4",
    },
    ["<M-5>"] = {
      "<cmd> lua require('harpoon'):list():select(5) <CR>",
      "Select 5",
    },
  },
}

M.telescope = {
  n = {
    ["<leader>fs"] = {
      "<cmd> Telescope lsp_document_symbols <CR>",
      "find document symbol",
    },
    ["<leader>fS"] = {
      "<cmd> Telescope lsp_workspace_symbols <CR>",
      "find workspace symbol",
    },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles only_cwd=true <CR>", "Find oldfiles" },
  },
}

return M
