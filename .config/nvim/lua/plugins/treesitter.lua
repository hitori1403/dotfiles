return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = "all",
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				autotag = {
					enable = true
				},

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},

				indent = {
					enable = true
				}
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
