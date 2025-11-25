return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- web
        "javascript",
        "typescript",
        "vue",
        "css",

        "lua",
        "json5",
        "rust",
        "go",
        "dockerfile",
        "markdown",
      },
    },
  },
}
