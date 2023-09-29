local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- Colorscheme
	use("sainnhe/gruvbox-material")

	-- [[ ICONS

	use({
		"nvim-tree/nvim-web-devicons",
		config = [[require('nvim-web-devicons').setup {}]],
	})

	-- vscode-like pictograms for neovim lsp completion items
	use "onsails/lspkind.nvim"

	-- ]]

	-- [[ LINES

	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = [[require('config.lualine')]],
	})

	-- Buffer line
	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = "nvim-tree/nvim-web-devicons",
		config = [[require("bufferline").setup {}]],
	})

	-- ]]

	-- [[ LSP

	-- Snippets
	use("L3MON4D3/LuaSnip")

	-- Autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",                    -- LSP source for nvim-cmp
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }, -- Snippets source for nvim-cmp
		},
		config = [[require('config.cmp')]],
		wants = "LuaSnip",
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Collection of configurations for built-in LSP client
	use({
		"neovim/nvim-lspconfig",
		config = [[require('config.lspconfig')]],
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = [[require('config.null-ls')]],
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- Java LSP
	use 'mfussenegger/nvim-jdtls'

	-- ]]

	-- [[ TREESITTER

	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = [[require('config.treesitter')]],
	})

	-- Auto tags
	use {
		'windwp/nvim-ts-autotag',
		requires = { "nvim-treesitter/nvim-treesitter" },
	}

	--]]	

	-- [[ TELESCOPE

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
		config = [[require('config.telescope')]]
	})

	use {
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	}

	use { 'nvim-telescope/telescope-ui-select.nvim' }

	-- ]]

	use({
		"iamcco/markdown-preview.nvim",
		run = function() vim.fn["mkdp#util#install"]() end,
	})

	-- Async run
	use 'tpope/vim-dispatch'


	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
