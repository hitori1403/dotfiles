require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"bash",
		"c",
		"c_sharp",
		"cmake",
		"cpp",
		"css",
		"csv",
		"dockerfile",
		"go",
		"gomod",
		"gosum",
		"gowork",
		"html",
		"ini",
		"java",
		"javascript",
		"json",
		"lua",
		"markdown",
		'passwd',
		"perl",
		"php",
		"python",
		"regex",
		"ruby",
		"rust",
		"sql",
		"toml",
		"typescript",
		"vim",
		"vimdoc",
		"xml",
		"yaml",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	autotag = {
		enable = true
	},

	-- Enable comment
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	}
})
