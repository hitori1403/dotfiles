local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- javascript, html, ...
		null_ls.builtins.formatting.prettier.with({
			disabled_filetypes = { 'html' }
		}),

		-- python
		null_ls.builtins.diagnostics.pylint,
		null_ls.builtins.formatting.yapf,
		null_ls.builtins.formatting.isort,

		-- bash
		null_ls.builtins.formatting.shfmt,

		-- sql
		null_ls.builtins.formatting.sql_formatter
	},
})
