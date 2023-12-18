local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })

lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "jedi_language_server"
end, lvim.lsp.automatic_configuration.skipped_servers)

require("lvim.lsp.manager").setup("tsserver", {
  capabilities = capabilities,
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end, -- disable bacause the bug is fucking annoying!!!
  },
  settings = {
    diagnostics = {
      ignoredCodes = { 6133 }
    }
  },
})

require("lvim.lsp.manager").setup("eslint", {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll"
    })
  end,
})

require("lvim.lsp.manager").setup("rust_analyzer", {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false
      },
      lens = {
        run = {
          enable = false
        },
        debug = {
          enable = false
        }
      }
    }
  }
})

require("lvim.lsp.manager").setup("emmet_ls", {
  cmd = { "emmet-ls", "--stdio" },
  capabilities = capabilities,
  filetypes = {
    "css",
    "html",
    "javascriptreact",
    "typescriptreact"
  }
})

-- local eslintrc = vim.fn.glob(".eslintrc*", false, true)

-- if not vim.tbl_isempty(eslintrc) then
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   {
--     exe = "eslint_d",
--     -- args = { "--stdin", "--cache" },
--     filetypes = {
--       "typescript",
--       "typescriptreact",
--       "javascript",
--       "javascriptreact"
--     }
--   }
-- }

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   {
--     command = "eslint_d",
--     args = { "--stdin", "--cache" },
--     filetypes = {
--       "typescript",
--       "typescriptreact",
--       "javascript",
--       "javascriptreact"
--     }
--   }
-- }

-- local code_actions = require "lvim.lsp.null-ls.code_actions"
-- code_actions.setup {
--   {
--     exe = "eslint_d",
--     filetypes = {
--       "typescript",
--       "typescriptreact",
--       "javascript",
--       "javascriptreact"
--     },
--   },
-- }
-- end
