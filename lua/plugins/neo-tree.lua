return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle position=left<CR>", desc = "Open the neo-tree",      mode = { "n", "v" } },
		{
			"<leader>fE",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
			end,
			desc = "Explorer NeoTree (cwd)",
		},
		{ "<leader>E",  "<leader>fE",                            desc = "Explorer NeoTree (cwd)", remap = true },
		{
			"<leader>be",
			function()
				require("neo-tree.command").execute({ source = "buffers", toggle = true })
			end,
			desc = "Buffer explorer",
		},
		{
			"<leader>ge",
			function()
				require("neo-tree.command").execute({ source = "git_status", toggle = true })
			end,
			desc = "Git explorer",
		},
	},
	config = true,
}
