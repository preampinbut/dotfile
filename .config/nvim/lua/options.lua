require "nvchad.options"

-- add yours here!
local o = vim.o

o.relativenumber = true
o.wrap = true
o.showcmd = true
o.scrolloff = 15
o.clipboard = "unnamedplus"

vim.g.vscode_snippets_path = vim.fn.expand "$HOME/.config/Code/User/snippets/"
