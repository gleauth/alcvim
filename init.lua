-- 此文件作为neovim打开的时初始调用的配置
-- 实验性lua加载器
vim.loader.enable()
-- 基础选项和快捷命令
require("core.coreinit")
-- 插件管理安装
require("boot.lazyinit")
-- 附加的命令
require("core.extracmds")
