local dap, dapui = require("dap"), require("dapui")
dapui.setup()

require("nvim-dap-virtual-text").setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dap.adapters.node = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/workspace/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},

}

-- dap.adapters.chrome = {
--     type = 'executable',
--     command = 'node',
--     args = {os.getenv('HOME') .. '/workspace/vscode-chrome-debug/out/src/chromeDebug.js'}
-- }

-- local attach_to_process = {
--   name = 'Attach to process',
--   type = 'node',
--   request = 'attach',
--   processId = require'dap.utils'.pick_process,
--   host = '0.0.0.0',
--   sourceMaps = true,
--   port = 9229,
-- }

local js_filetypes = { 'javascript', 'javascript.jsx', 'typescript', 'typescript.tsx', 'cucumber'}
-- for _, value in ipairs(js_filetypes) do
--   dap.configurations[value] = { attach_to_process }
-- end

require('dap.ext.vscode').load_launchjs(nil, { node = js_filetypes })

