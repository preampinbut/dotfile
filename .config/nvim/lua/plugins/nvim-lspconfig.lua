return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "single",
        },
      },
      servers = {
        vue_ls = {
          settings = {
            css = {
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
        ["*"] = {
          keys = {
            {
              "[[",
              function()
                Snacks.words.jump(-(vim.v.count1 * 2))
              end,
              has = "documentHighlight",
              desc = "Prev Reference??",
              enabled = function()
                return Snacks.words.is_enabled()
              end,
            },
          },
        },
      },
      inlay_hints = {
        enabled = false,
      },
    },
  },
}
