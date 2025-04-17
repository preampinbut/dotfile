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
  "dartls",
  "prismals",
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

local mason_registry = require "mason-registry"
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
  .. "/node_modules/@vue/language-server"

if ts_ls == true then
  lspconfig.ts_ls.setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = vue_language_server_path,
          languages = { "vue" },
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
  }
end

lspconfig.volar.setup {
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

lspconfig.eslint.setup {
  flags = {
    allow_incremental_sync = false,
    debounce_text_changes = 1000,
  },
}

lspconfig.tailwindcss.setup {
  flags = {
    debounce_text_changes = 1000,
  },
}
