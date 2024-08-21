require "nvchad.options"

-- add yours here!

local o = vim.o

o.relativenumber = true
o.wrap = true
o.showcmd = true
o.scrolloff = 15

vim.g.vscode_snippets_path = vim.fn.expand "$HOME/.config/Code/User/snippets/"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
