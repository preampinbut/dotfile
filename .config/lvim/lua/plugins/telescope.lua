local actions = require "telescope.actions"
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  "node_modules",
}
-- NOTE: Fix autocmd loadview not working when open with telescope
lvim.builtin.telescope.defaults.mappings.i["<CR>"] = function(prompt_bufnr)
  vim.cmd.stopinsert()
  vim.defer_fn(function() actions.select_default(prompt_bufnr) end, 10)
end
