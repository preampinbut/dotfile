local node_modules = io.popen("npm root -g"):read "l" .. "/"

require("nvchad.configs.lspconfig").defaults()

vim.lsp.enable "html"
vim.lsp.enable "cssls"

vim.lsp.enable "tailwindcss"

vim.lsp.enable "vue_ls"

vim.lsp.enable "ts_ls"
vim.lsp.config("ts_ls", {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = node_modules .. "@vue/language-server",
        languages = {
          "vue",
        },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  },
})

vim.lsp.enable "eslint"

vim.lsp.enable "gopls"
