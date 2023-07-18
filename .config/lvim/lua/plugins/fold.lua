lvim.builtin.which_key.setup.plugins.presets.z = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldenable = true

function InitView()
  local filename = vim.fn.expand('%:p')
  local home_directory = vim.loop.os_homedir() or ''
  filename = string.gsub(filename, home_directory, '~')
  filename = string.gsub(filename, '/', '=+')
  filename = filename .. "="
  local view_file = vim.fn.stdpath("state") .. '/view/' .. filename
  if vim.fn.filereadable(view_file) == 0 then
    vim.cmd('mkview')
  end
end

vim.cmd [[
augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent! loadview
augroup END
]]

vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      callback = function()
        vim.defer_fn(function()
          local str = vim.api.nvim_replace_termcodes("<cmd>lua InitView()<cr>:silent! loadview<cr>", true, false,
            true)
          vim.api.nvim_feedkeys(str, "m", false)
        end, 60)
      end,
    })
  end,
})
