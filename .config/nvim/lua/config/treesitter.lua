require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"bash",
		"c",
		"c_sharp",
		"cmake",
		"cpp",
		"dockerfile",
		"go",
		"html",
		"java",
		"javascript",
		"json",
		"lua",
		"markdown",
		"php",
		"python",
		"rust",
		"sql",
		"typescript",
		"yaml",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
})
