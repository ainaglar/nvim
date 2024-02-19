local opt = vim.opt
--显示行号
opt.number = true
--显示相对行号
opt.relativenumber = true
--自动缩进
opt.autoindent = true
--自动换行
opt.wrap = true

--设置tab为4个空格
opt.tabstop = 4
opt.shiftwidth = 4

--启用鼠标
opt.mouse:append('a')
opt.mousemoveevent = true
--系统剪切板
opt.clipboard:append('unnamedplus')
opt.swapfile = false
opt.exrc = true
--默认新窗口右边和下边
opt.splitright = true
opt.splitbelow = true

--搜索
opt.ignorecase = true
opt.smartcase = true

--外观
opt.termguicolors = true
opt.signcolumn = "yes"
--关闭再开，可以恢复历史版本
opt.undofile = true
--设置默认编码
opt.encoding = "utf-8"
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 99
