local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_a = {
  components.mode,
  "mode"
}

lvim.builtin.bufferline.active = true
lvim.builtin.bufferline.options.mode = "buffers"
lvim.builtin.bufferline.options.show_close_icon = false
lvim.builtin.bufferline.options.show_buffer_close_icons = false
