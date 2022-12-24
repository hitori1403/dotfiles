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

	-- Icons
	use({
		"nvim-tree/nvim-web-devicons",
		config = [[require('nvim-web-devicons').setup {}]],
	})

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

	-- Snippets plugin
	use("L3MON4D3/LuaSnip")

	-- Autocompletion plugin
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }, -- Snippets source for nvim-cmp
		},
		config = [[require('config.cmp')]],
		wants = "LuaSnip",
	})

	-- Autopair
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

	-- tree-sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = [[require('config.treesitter')]],
	})

	-- null-ls
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = [[require('config.null-ls')]],
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- auto tags
	use {
		'windwp/nvim-ts-autotag',
		config = [[require('nvim-ts-autotag').setup()]]
	}

	-- Fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
