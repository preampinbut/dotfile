return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      if pager then
        return
      end
      require "configs.lspconfig"
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        enable = true,
        ignore = false,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      view = {
        width = 40,
        relativenumber = true,
      },
      on_attach = function(bufnr)
        local nvimtree = require "configs.nvimtree"
        nvimtree.on_attach(bufnr)
      end,
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<Tab>"] = "move_selection_next",
            ["<S-Tab>"] = "move_selection_previous",
          },
        },
      },
    },
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require "configs.rainbow"
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require "configs.indent"
    end,
  },

  {
    "copilotlsp-nvim/copilot-lsp",
  },

  {
    "zbirenbaum/copilot.lua",
    requires = {
      "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
      init = function()
        vim.g.copilot_nes_debounce = 500
      end,
    },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        nes = {
          enabled = true,
          keymap = {
            accept_and_goto = "<leader>p",
            accept = false,
            dismiss = "<ESC>",
          },
        },
      }
    end,
  },
}
