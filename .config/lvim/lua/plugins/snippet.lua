lvim.plugins = {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "<CurrentMajor>.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
}

require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.expand("$HOME/.config/Code/User/snippets") } })
