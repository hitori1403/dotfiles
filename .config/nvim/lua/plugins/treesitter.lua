return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = {
					"asm",
					"bash",
					"c",
					"c_sharp",
					"cmake",
					"comment",
					"cpp",
					"css",
					"csv",
					"disassembly",
					"dockerfile",
					"dot",
					"dtd",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"go",
					"gomod",
					"gosum",
					"gowork",
					"html",
					"ini",
					"java",
					"javascript",
					"json",
					"linkerscript",
					"lua",
					"luap",
					"markdown",
					"nasm",
					"objdump",
					'passwd',
					"pem",
					"perl",
					"php",
					"requirements",
					"printf",
					"python",
					"regex",
					"ruby",
					"rust",
					"smali",
					"solidity",
					"sql",
					"ssh_config",
					"strace",
					"toml",
					"tsx",
					"typescript",
					"udev",
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

				-- Needed because treesitter highlight turns off autoindent for php files
				indent = {
					enable = true
				},

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end
	},
	-- Auto tags
	{
		'windwp/nvim-ts-autotag',
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	-- Show code context
	{
		'nvim-treesitter/nvim-treesitter-context',
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	-- [[ Comment
	{
		'JoosepAlviste/nvim-ts-context-commentstring',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		lazy = true,
		opts = {
			enable_autocmd = false,
		}
	},
	{
		'numToStr/Comment.nvim',
		dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
		config = function()
			require('Comment').setup {
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			}
		end
	}
	-- ]]
}
