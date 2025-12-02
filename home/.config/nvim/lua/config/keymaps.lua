-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

-- formatting
map({ "n", "x" }, "<leader>cf", function()
  local never = false

  for _, value in ipairs(vim.g.format_eslint_ft) do
    if value == vim.bo.filetype then
      never = true
      break -- Exit the loop once found
    end
  end

  if never then
    vim.cmd("LspEslintFixAll")
  else
    LazyVim.format({ force = true })
  end
end, { desc = "Format" })
