local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_a = {
  components.mode,
  "mode"
}
lvim.builtin.bufferline.options.mode = "tabs"
