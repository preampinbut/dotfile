return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
    opts = {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    },
  },
}
