return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set('n', '<space>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', '<space>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)
				end,
			})

			local lspconfig = require("lspconfig")

			-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
			local servers = {
				'asm_lsp',
				'bashls',          -- Bash
				"clangd",          -- C/C++
				'cssls',           -- CSS
				"gopls",           -- Go
				"intelephense",    -- PHP
				"lemminx",         -- XML
				"lua_ls",          -- Lua
				"pylsp",           -- Python
				"ruff",            -- Python linter
				"solidity_ls_nomicfoundation", -- Solidity
				"solargraph",      -- Ruby
				"ts_ls",           -- JavaScript
				"yamlls",          -- YAML
			}

			local lsp_flags = {
				-- This is the default in Nvim 0.7+
				debounce_text_changes = 150,
			}

			-- Add additional capabilities supported by nvim-cmp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					-- on_attach = on_attach,
					flags = lsp_flags,
					-- single_file_support = true,
					capabilities = capabilities,
				})
			end

			local html_capabilities = vim.lsp.protocol.make_client_capabilities()
			html_capabilities.textDocument.completion.completionItem.snippetSupport = true

			lspconfig.html.setup {
				capabilities = html_capabilities,
			}

			lspconfig.omnisharp.setup {
				-- on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
				cmd = { 'dotnet', '/usr/lib/omnisharp/OmniSharp.dll' }
			}

			lspconfig.ts_ls.setup {
				-- on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
				init_options = {
					preferences = {
						disableSuggestions = true
					}
				}
			}
		end
	},
	-- Java LSP
	{
		'mfussenegger/nvim-jdtls',
		dependencies = { 'neovim/nvim-lspconfig' },
		lazy = true
	},
	-- Rust LSP
	{
		'mrcjkb/rustaceanvim',
		ft = { 'rust' },
	},
}
