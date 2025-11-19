local node_modules = io.popen("npm root -g"):read "l" .. "/"

require("nvchad.configs.lspconfig").defaults()

vim.lsp.enable "emmet_ls"
vim.lsp.enable "html"

vim.lsp.config("cssls", {
  settings = {
    css = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})
vim.lsp.enable "cssls"

vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      classAttributes = {
        "class",
        "className",
        "class:list",
        "classList",
        "ngClass",
        "activeClass",
        "inactiveClass",
        "ui",
      },
    },
  },
})
vim.lsp.enable "tailwindcss"

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = node_modules .. "@vue/language-server",
  languages = {
    "vue",
  },
}
local tsserver_filetype = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "vue",
}

vim.lsp.config("vtsls", {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = tsserver_filetype,
})
-- vim.lsp.enable "vtsls"

vim.lsp.config("ts_ls", {
  init_options = {
    plugins = {
      vue_plugin,
    },
  },
  filetypes = tsserver_filetype,
})
vim.lsp.enable "ts_ls"

vim.lsp.config("vue_ls", {
  init_options = {
    typescript = {
      tsdk = node_modules .. "node_modules/typescript/lib",
    },
  },
  settings = {
    css = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
  before_init = function(_, config)
    local current_dir = vim.fn.getcwd()
    local lib_path = vim.fs.find("node_modules/typescript/lib", { path = current_dir, upward = true })[1]
    if lib_path then
      config.init_options.typescript.tsdk = lib_path
    end
  end,
})
vim.lsp.enable "vue_ls"

local base_on_attach = vim.lsp.config.eslint.on_attach
vim.lsp.config("eslint", {
  on_attach = function(client, bufnr)
    if not base_on_attach then
      return
    end

    base_on_attach(client, bufnr)
    vim.keymap.set(
      { "n", "x" },
      "<leader>fm",
      "<cmd>LspEslintFixAll<CR>",
      { buffer = true, desc = "general format document" }
    )
  end,
})
vim.lsp.enable "eslint"

vim.lsp.enable "prismals"

vim.lsp.enable "gopls"
