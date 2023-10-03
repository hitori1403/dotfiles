local jdtls = require('jdtls')
local toggleterm = require('toggleterm')

-- [[ nvim-jdtls

local home = os.getenv("HOME")

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		-- Note: Most of the configs are configured by Arch linux's jdtls
		'jdtls',
		'-configuration', home .. '/.jdtls/config',

		-- See `data directory configuration` section in the README
		'-data', home .. '/.jdtls/workspace'
	},

	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = jdtls.setup.find_root({ '.git', 'build.xml', 'pom.xml', 'build.gradle', 'build.gradle.kts',
		'settings.gradle', 'settings.gradle.kts' })
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)

-- Mappings
local feedkeys = function(keys)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'v', false)
end

vim.keymap.set('n', '<A-o>', jdtls.organize_imports)
vim.keymap.set('n', 'crv', jdtls.extract_variable)
vim.keymap.set('v', 'crv', function()
	feedkeys('<Esc>')
	jdtls.extract_variable(true)
end)
vim.keymap.set('n', 'crc', jdtls.extract_constant)
vim.keymap.set('v', 'crc', function()
	feedkeys('<Esc>')
	jdtls.extract_constant(true)
end)
vim.keymap.set('v', 'crm', function()
	feedkeys('<Esc>')
	jdtls.extract_method(true)
end)

-- ]]

-- [[ Mappings for build tools

local root_files = {
	maven = { 'pom.xml' },
	gradle = {
		'build.gradle',
		'build.gradle.kts',
		'settings.gradle',
		'settings.gradle.kts'
	}
}

local build_mappings = {
	maven = function()
		vim.keymap.set('n', '<F9>', function()
			vim.cmd.write()
			toggleterm.exec(string.format('cd %s; mvn spring-boot:run', config.root_dir))
		end)
	end,
	gradle = function()
		vim.keymap.set('n', '<F9>', function()
			vim.cmd.write()
			toggleterm.exec(string.format('cd %s; gradle bootRun', config.root_dir))
		end)
	end
}

local has_build_tool = false

for build_tool, patterns in pairs(root_files) do
	if jdtls.setup.find_root(patterns) then
		has_build_tool = true
		build_mappings[build_tool]()
		break
	end
end

if not has_build_tool then
	vim.keymap.set('n', '<F9>', function()
		vim.cmd.write()
		toggleterm.exec(vim.fn.expandcmd('javac % && java %:r'))
	end)
end

-- ]]
