return {
	{
		"rhysd/accelerated-jk", --加速jk
		config = function()
			vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)")
			vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)")
		end,
	},
	{
		"folke/persistence.nvim", --恢复上次退出时的窗口布局
		config = function()
			require("persistence").setup()
			vim.keymap.set("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]])
			vim.keymap.set("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true})<cr>]])
			vim.keymap.set("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]])
		end
	},
	{
		"RRethy/vim-illuminate", --高亮光标下的变量
		config = function()
			require('illuminate').configure()
		end
	},
	{
		"folke/which-key.nvim",
		config = true,
	},
	{
		"folke/flash.nvim",
		config = function()
			require("flash").setup()
			vim.keymap.set({ "n", "x", "o" }, "s",
				function()
					require("flash").jump({
						search = {
							mode = function(str)
								return "\\<" .. str
							end,
						},
					})
				end
			)
			vim.keymap.set({ "n", "x", "o" }, "S",
				function()
					require("flash").treesitter()
				end
			)
			vim.keymap.set({ "o" }, "r",
				function()
					require("flash").remote()
				end
			)
			vim.keymap.set({ "o", "x" }, "R",
				function()
					require("flash").treesitter_search()
				end
			)
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		config = function()
			require("window-picker").setup({
				filter_rules = {
					include_current_win = true,
					bo = {
						filetype = { "fidget" }
					}
				}
			})
			vim.keymap.set("n",
				"<leader>p",
				function()
					local window_number = require('window-picker').pick_window()
					if window_number then vim.api.nvim_set_current_win(window_number) end
				end
			)
		end
	},
	{
		"echasnovski/mini.comment",
		config = true,
	},
	{
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- stylua: ignore start
      map("n", "]h", gs.next_hunk, "Next Hunk")
      map("n", "[h", gs.prev_hunk, "Prev Hunk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
  },
}
}
