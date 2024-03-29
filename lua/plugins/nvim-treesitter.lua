return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/playground",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = { "vim", "bash", "c", "cpp", "json", "lua", "python", "markdown", "markdown_inline", "cmake" },
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
		playground = {
			enable = true,
		},
		fold = {
			enable = true,
		},
		textobjects = {
			select = {
				enable = true,

				lookahead = true,

				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
				},
				selection_modes = {
				['@parameter.outer'] = 'v', -- charwise
					['@function.outer'] = 'V',  -- linewise
					['@class.outer'] = '<c-v>', -- blockwise
				},
				include_surrounding_whitespace = false,
			},
		},
	},
}
