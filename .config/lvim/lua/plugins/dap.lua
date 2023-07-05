local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = 'lldb'
}

local dep_vscode = require('dap.ext.vscode')
dep_vscode.load_launchjs(nil, { lldb = { 'rust' } })

-- Define a function to build the Rust app and start the debug session
function BuildAndDebug()
  dep_vscode.load_launchjs(nil, { lldb = { 'rust' } })
  local file_extension = vim.fn.expand('%:e') -- Get the file extension of the current file
  if file_extension == 'rs' then
    -- Run the build command (e.g., cargo build)
    local build_job = vim.fn.jobstart('cargo build', {
      cwd = vim.fn.expand('%:p:h') -- Set the working directory to the project's directory
    })

    vim.fn.jobwait({ build_job }, -1)
  end
  -- Start the debug session
  dap.continue()
end

-- Bind the function to a key mapping (e.g., <F5>)
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua BuildAndDebug()<CR>',
  { noremap = true, silent = true })

lvim.builtin.which_key.mappings.d.s = { "<cmd>lua BuildAndDebug()<CR>", "Start" }
