return {
	"akinsho/bufferline.nvim",
	config = function()
		vim.opt.termguicolors = true
		require("bufferline").setup {
			options = {
				-- 使用 nvim 内置lsp
				diagnostics = "nvim_lsp",
				-- 左侧让出 nvim-tree的位置
				offsets = {{
					filetype = "neo-tree",
					text = "File Explorer",
					highlight = "Directory",
					text_align = "left"
				}},
				hover = {
					enabled = true,
					delay = 200,
					reveal = { 'close' }
				},
				groups = {
					items = {
						require('bufferline.groups').builtin.pinned:with({ icon = ""})
					}
				},
			}
		}
		vim.keymap.set("n", "<leader>pn", "<cmd>BufferLineTogglePin<cr>")
	end,
}
