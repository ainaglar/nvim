return {
	"github/copilot.vim",
	config = function()
		vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false
		})
		vim.g.copilot_no_tab_map = true
		vim.keymap.set('i', '<Tab>', 'copilot#Accept("\\<Tab>")', {
			expr = true,
			replace_keycodes = false
		})
		vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
		vim.keymap.set('i', '<C-K>', '<Plug>(copilot-accept-line)')
		vim.keymap.set('i', '<C-H>', '<Plug>(copilot-dismiss)')
	end
}
