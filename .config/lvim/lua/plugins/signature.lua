lvim.autocommands = {
  {
    "BufEnter",
    {
      pattern = { "*" },
      callback = function()
        require "lsp_signature".on_attach()
      end
    }
  }
}
