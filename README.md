# Neovim配置

- **注意**

- 调整配置

1. rnvimr插件：用于在浮动窗口调用ranger，由于windows用户无法使用ranger，则需要删除此插件

2. sqlite.lua插件：由于Telescope frecency和yanky.nvim，以及一些其它功能需要sqlite，所以请在[sqlite.lua](https://github.com/kkharji/sqlite.lua)中查看详细配置

3. 需要说明的是，在将此配置使用之前，需要先修改这些设置，否则neovim使用会报错

- 基础工具

1. 需要在系统环境中安装一些基础工具,如gcc,node,git,curl,wget,unzip,make,fd,rg等等

2. Windows下推荐使用Msys2安装基础工具，官网:[msys2](https://www.msys2.org)

3. 确保系统能正常连接国际互联网，即能正常访问github

## Neovim的安装

- 具体可以看[这里](https://github.com/neovim/neovim/wiki/Installing-Neovim)

## 本配置的插件安装及其使用

### 安装插件

- linux:

- 打开终端输入: `git clone https://github.com/uniful/lazynvim.git ~/.config/nvim`

- windows:

- 打开PowerShell输入: `git clone https://github.com/uniful/lazynvim.git $env:LOCALAPPDATA\nvim`

- 终端输入nvim，插件便会自动安装

- 插件安装完成后，使用checkhealth命令查看有没有错误

## 基础插件介绍

### lsp(Language Server Protocol)

> 简介:此协议定义了在编辑器或IDE与语言服务器之间使用的协议，该语言服务器提供了例如自动补全，转到定义，查找所有引用等的功能

- 语言服务器可以自行安装，也可以通过mason.nvim插件安装。

- 使用mason.nvim安装语言服务

1. 具体需要安装的语言服务可以去mason.nvim插件的地址[mason.nvim](https://github.com/williamboman/mason.nvim)查看

2. 在plugins/lspconfig.lua文件中修改需要补全的服务器，在下方的排除列表中进行取消，则mason.nvim插件会自行安装所需的服务。

- 自行安装语言服务

1. 去nvim-lspconfig的语言服务列表[server](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)中查看

2. 不需要的语言服务器可以在plugins/lspconfig.lua文件中删除

### completion

- 此配置中使用的是nvim-cmp作为自动补全框架，基本补全设置已经够用了

### dap

- Neovim官方并没有实现DapConfig，插件来源于第三方作者，调试c/c++还行，其它语言并不好用。

- 自定义调试器

1. 在debugger/lang/dap-cpp.lua文件中, 修改你使用的c/c++调试适配器, 具体可以看[dapInstall](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation),自己选择自己需要的适配器，然后修改就可以了。

2. lua调试：来源于一个插件。dap-lua.lua文件基本上不用修改。

3. bash调试，使用的是mason安装调试器，毕竟作者推荐的就是这个。

3. 如果不想neovim实现调试功能，则可以删除debugger文件夹内所有文件，以及plugins/dapconfig.lua文件。

### Diagnotics

- 使用null-ls插件来诊断，具体的诊断程序及其配置在plugins/null-ls.lua文件夹，对于不用的诊断程序或语言可以删除，需要的也可以自行添加或修改

### treesitter

- treesitter语法高亮感觉比自带的好多了，不过要感觉更好看，还需要搭配一套好看的主题。

- 如果想更换主题，可以去treesitter的插件官网[Colorschemes](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes)查看

### 更多neovim插件

- 插件集合[neovim-awesome](https://github.com/rockerBOO/awesome-neovim)

## 启动优化

- 在WSL2上使用ArchLinux上进行测试，基本打开时间在70ms左右

## 自定义配置

- 每个文件夹下面都有README，介绍了每个文件的作用，如果想自己安装插件、修改配置都非常方便
