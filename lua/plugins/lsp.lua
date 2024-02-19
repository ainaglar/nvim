return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig",
		"folke/neoconf.nvim",
		"folke/neodev.nvim",
		"nvimdev/lspsaga.nvim",
	},
	config = function()
		local servers = {
			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
			pyright = {},
			marksman = {},
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
				capabilities = {
					offsetEncoding = { "utf-16" },
				},
			},
			cmake = {
				cmd = { "cmake-language-server" },
			},
		}
		local inlay_inits = {
			enable = true,
		}
		local on_attach = function(_, bufnr)
			-- Enable completion triggered by <c-x><c-o>
			require("clangd_extensions.inlay_hints").setup_autocmd()
			require("clangd_extensions.inlay_hints").set_inlay_hints()
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			nmap('<leader>pd', '<cmd>Lspsaga peek_definition<CR>', 'Peek Definition')
			nmap('<leader>pr', '<cmd>Lspsaga finder ref<CR>', '[F]inder')
			nmap("K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
			nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
			nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
			nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
			nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
			nmap("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "[W]orkspace [L]ist Folders")
			nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
			nmap("<leader>rn", "<cmd>Lspsaga rename ++project<cr>", "[R]e[n]ame")
			nmap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "[C]ode [A]ction")
			nmap("<leader>da", require("telescope.builtin").diagnostics, "[D]i[A]gnostics")
			nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			nmap('<leader>ot', '<cmd>Lspsaga outline<CR>', 'OutLine')
			nmap("<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, "[F]ormat code")
		end
		require("neoconf").setup()
		require("neodev").setup()
		require("lspsaga").setup()
		require("mason").setup()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers), })
		for servers, config in pairs(servers) do
			require("lspconfig")[servers].setup(
				vim.tbl_deep_extend("keep",
					{
						on_attach = on_attach,
						capabilities = capabilities,
						inlay_hints = inlay_inits,
					},
					config
				)
			)
		end
	end,
}
