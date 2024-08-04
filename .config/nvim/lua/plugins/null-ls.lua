return {
	'nvimtools/none-ls.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim'
	},
	opts = function()
		local null_ls = require("null-ls")

		return {
			sources = {
				null_ls.builtins.formatting.asmfmt.with {
					filetypes = { 'asm', 'nasm' },
					extra_filetypes = { 'toml' }
				},
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.yamlfmt
			}
		}
	end
}
