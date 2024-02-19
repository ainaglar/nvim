return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'tomasky/bookmarks.nvim',
	},
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- 环境里要安装ripgrep
		vim.keymap.set('n', '<leader><space>', builtin.buffers, {})
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = '[?] Find recently opened files' })
		vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, { desc = '[?] Find definitions' })
		vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = '[?] Find references' })
		vim.keymap.set('n', '<leader>ld', builtin.lsp_document_symbols, { desc = '[?] Find symbols in current document' })
		vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = '[?] Find symbols in workspace' })
		vim.keymap.set('n', '<leader>tt', builtin.treesitter, { desc = '[?] Find treesitter symbols' })
		vim.keymap.set('n', '<leader>cs', '<cmd>Telescope colorscheme<cr>', { desc = '[?] Find colorschemes' })
		vim.keymap.set('n', '<leader>bm', '<cmd>Telescope bookmarks list<cr>', { desc = '[?] Find bookmarks' })
		vim.keymap.set('n', '<leader>/', function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false,
			})
		end, { desc = '[/] Fuzzily search in current buffer' })
		require('bookmarks').setup {
			-- sign_priority = 8,  --set bookmark sign priority to cover other sign
			save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
			keywords = {
				["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
				["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
				["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
				["@n"] = "󰎞 ", -- mark annotation startswith @n ,signs this icon as `Note`
			},
			on_attach = function(bufnr)
				local bm = require "bookmarks"
				local map = vim.keymap.set
				map("n", "mm", bm.bookmark_toggle) -- add or remove bookmark at current line
				map("n", "mi", bm.bookmark_ann) -- add or edit mark annotation at current line
				map("n", "mc", bm.bookmark_clean) -- clean all marks in local buffer
				map("n", "mn", bm.bookmark_next) -- jump to next mark in local buffer
				map("n", "mp", bm.bookmark_prev) -- jump to previous mark in local buffer
				map("n", "ml", bm.bookmark_list) -- show marked file list in quickfix window
			end
		}
		require('telescope').load_extension('bookmarks')
	end,
}
