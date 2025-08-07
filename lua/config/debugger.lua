-- [nfnl] fnl/config/debugger.fnl
local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.after.event_initialized.dapui_config = function()
  return dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  return dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  return dapui.close()
end
return dap.listeners.before.event_exited.dapui_config
