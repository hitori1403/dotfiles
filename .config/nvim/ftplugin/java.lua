local util = require 'lspconfig.util'
local cwd = vim.fn.getcwd()

local root_files = {
	maven = { 'pom.xml' },
	gradle = {
		'build.gradle',
		'build.gradle.kts',
		'settings.gradle',
		'settings.gradle.kts'
	}
}

local build_keymaps = {
	maven = function()
		vim.keymap.set('n', '<F9>', function()
			vim.cmd.write()
			vim.cmd.Start { 'mvn spring-boot:run' }
		end)
	end,
	gradle = function()
		vim.keymap.set('n', '<F9>', function()
			vim.cmd.write()
			vim.cmd.Start { 'gradle bootRun' }
		end)
	end
}

local has_build_tool = false

for build_tool, patterns in pairs(root_files) do
	if util.root_pattern(unpack(patterns))(cwd) then
		has_build_tool = true
		build_keymaps[build_tool]()
		break
	end
end

if not has_build_tool then
	vim.keymap.set('n', '<F9>', function()
		vim.cmd.write()
		vim.cmd.Start { 'javac % && java %:r; read' }
	end)
end
