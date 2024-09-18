-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  "html",
  "cssls",
  "tailwindcss",
  "volar",
  "ts_ls",
  "clangd",
  "eslint",
  "emmet_ls",
  "jsonls",
  "rust_analyzer",
  "gopls",
  "csharp_ls",
  "pyright",
  "dockerls",
  "lemminx",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.gopls.setup {
  settings = {
    gopls = {
      buildFlags = { "-tags=" }, -- set tags here
    },
  },
}

--
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/bin/node_modules/@vue/typescript-plugin",
        languages = { "vue" },
      },
    },
  },
  -- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}

lspconfig.volar.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
}

lspconfig.cssls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    css = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
}
