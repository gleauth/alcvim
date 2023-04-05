-- 设置leader
vim.g.mapleader       = ";"
vim.g.maplocalleader  = ","
-- 自动缩进策略
vim.opt.filetype      = "plugin"
-- 防止包裹
vim.o.wrap            = false
-- 默认新窗口在右和下
vim.o.splitright      = true
vim.o.splitbelow      = true
-- 行号显示 绝对行号和相对行号
vim.o.number          = true
vim.o.relativenumber  = true
-- 显示标尺
vim.o.ruler           = true
-- 无操作时候交换文件写入磁盘等待的时间
vim.o.updatetime      = 100
-- 高亮当前文本行
vim.o.cursorline      = true
-- 等待按键时长的时间
vim.o.timeout         = true
vim.o.timeoutlen      = 500
-- 外部修改时自动加载
vim.o.autowrite       = true
vim.o.autoread        = true
-- 退出时提示确认
vim.o.confirm         = true
-- 编码设置和检测
vim.o.fileencoding    = "utf-8"
vim.opt.fileencodings = {"ucs-bom","utf-8","utf-16","utf-32","gb18030","gbk","gb2312","latin1"}
vim.opt.fileformats   = {"unix","dos"}
-- 显示左侧图标指示列
vim.wo.signcolumn     = "yes"
-- 搜索设置
vim.o.ignorecase      = true
vim.o.smartcase       = true
vim.o.incsearch       = true
vim.o.hlsearch        = true
-- 拼写建议
vim.o.spell           = true
vim.opt.spelllang     = {"en_us"}
-- 鼠标支持
vim.opt.mouse:append("a")
-- 启用系统剪切板
vim.opt.clipboard:append("unnamedplus")
-- 缓存文件设置
vim.o.backup          = false
vim.o.writebackup     = false
vim.o.swapfile        = false
-- 显示特殊字符
vim.o.list            = true
-- 空格占用以.显示
vim.opt.listchars     = {space="·",tab="▸ ",eol="↴"}
-- 补全增强
vim.o.wildmenu        = true
-- 终端24位色彩支持
vim.o.termguicolors   = true
-- 判断终端是否支持真色彩，如果支持就开启，否则不开启
--if (vim.fn.has('termguicolors') == 1) then
--    vim.o.termguicolors = true
--end
-- 设置缩进
vim.o.breakindent     = true
vim.o.autoindent      = true
vim.o.tabstop         = 4
vim.o.shiftwidth      = 4
vim.o.softtabstop     = 4
vim.o.expandtab       = true
vim.o.shiftround      = true
-- 插入括号时短暂跳转到另一半括号
vim.o.showmatch       = true
-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.o.whichwrap       = "<,>,[,]"
-- 补全最多显示16行
vim.o.pumheight       = 16
-- 使用增强状态栏插件后不再需要 vim 的模式提示
vim.o.showmode        = false
-- redrawtime
vim.o.redrawtime      = 10000
-- 菜单栏语言
vim.o.langmenu        = "en_US.UTF-8"
-- 在markdown文件中，使用fencend code blocks显示typescript语法高亮
vim.g.markdown_fenced_languages = {"ts=typescript"}
