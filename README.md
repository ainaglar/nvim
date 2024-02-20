# 我的neovim设置
## keymappings

1. 基础功能
    - 默认`<leader>`为空格，如果需要修改，在`init.lua`中修改`vim.g.mapleader = " "`即可

| 按键   | 功能    |
| :---: | :---:|
|`<leader>e`|打开/关闭neotree|
|`<leader>sh`|垂直打开窗口|
|`<leader>sv`|横向打开窗口|
|`<TAB>`|切换下一个buffer|
|`<S-TAB>`|切换上一个buffer|
|`<leader>nh`|取消搜索高亮|
|`<leader>nb`|关闭当前buffer|
|`<leader>t`|打开浮动窗口终端|
|`<leader>r`|code run|
|`<c-\>`|关闭打开的终端|

2. telescope

|按键|功能|
|:---:|:---:|
|`<leader>ff`|查找当前目录下的文件|
|`<leader>fg`|查找所有文件|
|`<leader><space>`|查找打开的文件|
|`<leader>fh`|查找帮助文件|
|`<leader>fo`|查找打开过的文件|
|`<leader>bm`|查找书签|
|`<leader>\`|当前文件内搜索|

3. LSP

|按键|功能|
|:---:|:---:|
|`<leader>pd`|小窗显示定义|
|`<leader>gd`|打开定义|
|`<leader>D`|type defenition|
|`<leader>lr`或者`gr`|打开reference|
|`<leader>pr`|打开referencr(使用lspsaga,推荐)|
|`<leader>ld`|查找当前文件的symbols|
|`<leader>lw`|查找当前工作文件夹的symbols|
|`<leader>tt`|查找自定义的变量|
|`<C-k>`     |查看当前函数需要填入的变量|
|`<leader>rn`|重命名|
|`<leader>da`|lsp错误或警告|
|`<leader>ca`|code action|
|`<leader>ot`|当前文件的结构|
|`K`         |hover documatation|

4. 书签
    在普通模式下，按`mi`，然后输入对应的标签如下所示
    ```
    @t = "☑️ ", `Todo`
	@w = "⚠️ ", `Warn`
	@f = "⛏ ", `Fix`
	@n = "󰎞 ", `Note`
    ```
    - 使用 `<leader>bm`可以查找创建好的bookmarks  
    - 在注释中使用TODO，比如在python下，输入`#TODO:`,可以高亮TODO并且显示相应的图案，可选的有`TODO,FIX,WARN,HACK,PERF,TEST,NOTE`
5. dap
    ```lua
   		vim.keymap.set('n', '<Leader>S', function() require 'telescope'.extensions.dap.configurations {} end)
		vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
		vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
		vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
		vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
		vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
		vim.keymap.set('n', '<Leader>lp',
			function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
		vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
		vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
		vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
			require('dap.ui.widgets').hover()
		end)
		vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
			require('dap.ui.widgets').preview()
		end)
		vim.keymap.set('n', '<Leader>df', function()
			local widgets = require('dap.ui.widgets')
			widgets.centered_float(widgets.frames)
		end)
		vim.keymap.set('n', '<Leader>ds', function()
			local widgets = require('dap.ui.widgets')
			widgets.centered_float(widgets.scopes)
		end)
    ```

## 项目单独配置
- 创建`.nvim.lua`文件，在这个文件中进行配置
1. dap
    1. python  
    python直接添加`require("nvim-dap-python").setup()`进行调试
    2. c/cpp  
    使用cpptools进行调试,例子如下
    ```lua
    local dap = require('dap')
    dap.adapters.cppdbg = {
        id = 'cppdbg',
	    type = 'executable',
	    command = "/home/aibaglar/extension/debugAdapters/bin/OpenDebugAD7",
    }
    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = true,
        },
        {
            name = 'Attach to gdbserver :1234',
            type = 'cppdbg',
            request = 'launch',
            MIMode = 'gdb',
            miDebuggerServerAddress = 'localhost:1234',
            miDebuggerPath = '/usr/bin/gdb',
            cwd = '${workspaceFolder}',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
        },
    }
    ```
## clangd
配置文件`~/.config/clangd/config.yaml`中
```
CompileFlags:
  Add:
    - '-I'
    - '需要的头文件的路径'
Diagnostics:
  UnusedIncludes: None  ：
```
- clangd启动项，在`lua/plugins/lsp.lua`中配置
```lua
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
				capabilities = {
					offsetEncoding = { "utf-16" },
				},

```
- 在windows下使用clangd的时候，需要下载llvm官方编译好的文件，然后将clangd启动项的cmd命令修改为你的clangd.exe的启动路径，否则会出现无法解析标准库的问题
