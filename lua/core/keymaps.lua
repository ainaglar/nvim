--主键设置为空格
vim.g.mapleader = ' '
local keymap = vim.keymap

--插入模式
--使用jk退出插入模式
keymap.set("i", "jk", "<ESC>")


--------------------视觉模式---------------
--单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--  ----------正常模式------------------
--增加窗口
keymap.set("n", "<leader>sv", "<C-w>v") --水平增加窗口
keymap.set("n", "<leader>sh", "<C-w>s") --垂直增加窗口
--在不同buffer间切换
keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })

--关闭buffer
keymap.set("n", "<leader>nb", ":bd<CR>")

--取消搜索高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

--nvim-tree
keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>")
