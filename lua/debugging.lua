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

require("dap-vscode-js").setup({
  adapters = { 'pwa-node'}
})

local js_filetypes = { 'javascript', 'javascript.jsx', 'typescript', 'typescript.tsx', 'cucumber'}
for _, language in ipairs(js_filetypes) do
  require("dap").configurations[language] = {
      {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require'dap.utils'.pick_process,
          cwd = "${workspaceFolder}",
      },
      {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest Tests",
          runtimeExecutable = "node",
          runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "--config",
              "jest.ui.config.js",
              "--setupFiles",
              "dotenv/config"
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
      }
  }
end
