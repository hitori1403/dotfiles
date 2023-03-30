local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- javascript, html, ...
		null_ls.builtins.formatting.prettier_eslint.with({
			disabled_filetypes = { 'html' }
		}),

		-- python
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,

		-- bash
		null_ls.builtins.formatting.shfmt
	},
})
