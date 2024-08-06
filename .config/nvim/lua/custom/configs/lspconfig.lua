local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

---@diagnostic disable-next-line: different-requires
local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "tsserver",
  "volar",
  "clangd",
  "prismals",
  "eslint",
  "emmet_ls",
  "jsonls",
  "rust_analyzer",
  "gopls",
  "csharp_ls",
  "pyright",
  "tailwindcss",
  "dockerls",
  "docker_compose_language_service",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}

local mason_registry = require "mason-registry"
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
  .. "/node_modules/@vue/language-server"

lspconfig.tsserver.setup {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "vue" },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}

lspconfig.eslint.setup {
  on_attach = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      ---@diagnostic disable-next-line: undefined-global
      buffer = buffer,
      command = "EslintFixAll",
    })
  end,
  capabilities = capabilities,
}

--
-- lspconfig.pyright.setup { blabla}
