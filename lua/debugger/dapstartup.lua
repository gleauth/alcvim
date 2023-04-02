-- 调用特定语言适配器
-- C/C++
require("debugger.lang.dap-cpp")
-- bash
require("debugger.lang.dap-bash")
-- lua
require("debugger.lang.dap-lua")

-- 额外的调试配置
require("dap.ext.vscode").load_launchjs(nil,{lldb = {"c","cpp"}})
