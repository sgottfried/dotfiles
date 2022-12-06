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
  args = {os.getenv('HOME') .. '/workspace/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.adapters.chrome = {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/workspace/vscode-chrome-debug/out/src/chromeDebug.js'}
}

local attach_to_process = {
  name = 'Attach to process',
  type = 'node',
  request = 'attach',
  processId = require'dap.utils'.pick_process,
  host = '0.0.0.0',
  sourceMaps = true,
  port = 9229,
}

-- local attach_to_chrome = {
--   type = 'chrome',
--   request = 'attach',
--   cwd = '${workspceFolder}/apps/marketplace-web',
--   sourceMaps = true,
--   protocol = 'inspector',
--   port = 9222,
--   webRoot = '${workspaceFolder}/apps/marketplace-web'
-- }

local js_filetypes = { 'javascript', 'javascript.jsx', 'typescript', 'typescript.tsx'}
for _, value in ipairs(js_filetypes) do
  dap.configurations[value] = { attach_to_process, attach_to_chrome }
end

-- require('dap.ext.vscode').load_launchjs(nil, { chrome = js_filetypes })

