require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = { "*" },
  callback = function()
    vim.F.npcall(vim.treesitter.start)
  end,
})

