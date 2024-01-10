return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			theme = "gruvbox-material",
			sections = {
				lualine_c = {
					{
						function()
							return require('nvim-navic').get_location()
						end,
						cond = function()
							return require('nvim-navic').is_available()
						end
					},
				}
			},
		}
	},
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {}
	}
}
