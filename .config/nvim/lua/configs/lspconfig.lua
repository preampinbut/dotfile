-- for easy access
local goBuildTags = ""
local ts_ls = true
local denols = false

-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  -- "lua_ls",
  -- "cssls",
  -- "volar",
  -- "eslint",
  -- "rust_analyzer",
  -- "gopls",
  "html",
  "tailwindcss",
  "clangd",
  "emmet_ls",
  "jsonls",
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

local function buf_format(client, bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format()
    end,
  })
  nvlsp.on_attach(client, bufnr)
end

lspconfig.lua_ls.setup {
  on_attach = buf_format,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    Lua = {
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lazy",
          "${3rd}/luv/library"
        }
      }
    }
  }
}

lspconfig.rust_analyzer.setup {
  on_attach = buf_format,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    ["rust_analyzer"] = {
      diagnistics = {
        enabled = true,
      },
    },
  },
}

lspconfig.gopls.setup {
  on_attach = buf_format,
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
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
    nvlsp.on_attach(client, bufnr)
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
