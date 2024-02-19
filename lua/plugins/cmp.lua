return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-emoji",
		"saadparwaiz1/cmp_luasnip",
		'onsails/lspkind.nvim',
		{
			"saadparwaiz1/cmp_luasnip",
			dependencies = {
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
				}
			}
		},
	},
	config = function()
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end
		require("luasnip.loaders.from_vscode").lazy_load()
		local luasnip = require("luasnip")
		local cmp = require 'cmp'
		cmp.setup {
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			sources = cmp.config.sources {
				{ name = 'nvim_lsp' },
				{ name = 'path' },
				{ name = 'luasnip' },
				{ name = "buffer" },
				{ name = "emoji" },
			},
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.recently_used,
					require("clangd_extensions.cmp_scores"),
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			window = {
				completion = {
					col_offset = -3,
					side_padding = 0,
					border = 'none',
					scrollbar = true,
					winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
				},
				documentation = {
					winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
					border = 'none',
					scrollbar = true,
					side_padding = 0,
				},
			},
			formatting = {
				fields = { 'kind', 'abbr', 'menu' },
				format = function(entry, vim_item)
					local kind =
						require('lspkind').cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
					local strings = vim.split(kind.kind, '%s', { trimempty = true })
					kind.kind = ' ' .. (strings[1] or '') .. ' '
					kind.menu = ' ' .. (strings[2] or '')

					return kind
				end,
			},
			mapping = cmp.mapping.preset.insert {
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- they way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			},
			experimental = {
				ghost_text = true,
			}
		}
		cmp.setup.cmdline('/', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' },
			}
		})

		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' },
				{ name = 'cmdline' }
			})
		})
	end,
}
