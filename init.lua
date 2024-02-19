--初始化插件管理器
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("core.options")
require("core.keymaps")
require("lazy").setup({
	{ import = "plugins" },
})

if vim.g.neovide then
	vim.g.neovide_refresh_rate = 165
	vim.g.neovide_fullscreen = false
	vim.o.guifont = "ComicShannsMono Nerd Font:h16"
	vim.g.neovide_transparency = 0.80
	vim.g.transparency = 0.8
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_vfx_mode = "pixiedust"
	vim.g.neovide_cursor_vfx_mode = "wireframe"
end
