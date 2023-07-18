lvim.builtin.which_key.setup.plugins.presets.z = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldenable = true
vim.cmd [[
augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* mkview
    " autocmd BufWinEnter *.* silent! loadview
augroup END
]]

function Mkview_if_no_view()
  local view_file = vim.fn.expand('%:p') .. '.view'
  if vim.fn.filereadable(view_file) == 0 then
    vim.cmd('mkview')
  end
end

vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      callback = function()
        vim.defer_fn(function()
          local str = vim.api.nvim_replace_termcodes("<cmd>lua Mkview_if_no_view()<cr>:silent! loadview<cr>", true, false,
            true)
          vim.api.nvim_feedkeys(str, "m", false)
        end, 60)
      end,
    })
  end,
})
