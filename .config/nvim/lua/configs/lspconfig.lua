-- for easy access
local goBuildTags = ""
local ts_ls = true
local denols = false

-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  "html",
  "cssls",
  "tailwindcss",
  "volar",
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

if denols == true and ts_ls == true then
  error "ts_ls and denols cannot be true at the same time"
end

if denols == true then
  table.insert(servers, "denols")
end

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
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    gopls = {
      buildFlags = { "-tags=" .. goBuildTags }, -- set tags here
    },
  },
}

if ts_ls == true then
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
  }
end

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
