local runners = {
	{ 'asm',        'as -o %:r.o % --32 && ld -o %:r %:r.o -m elf_i386 && ./%:r' },
	{ 'c',          'gcc -Wall % -o %:r && ./%:r' },
	{ 'cpp',        'g++ -Wall % -o %:r && ./%:r' },
	{ 'go',         'go run %' },
	{ 'java',       'javac % && java %:r' },
	{ 'javascript', 'node %' },
	{ 'php',        'php %' },
	{ 'python', {
		{ '<F9>',  'python %' },
		{ '<F10>', '[[ -f `cat .project` ]] && python `cat .project`' }
	}
	}
}

local set_keymap = function(binding)
	vim.keymap.set('n', binding[1], function()
		vim.cmd.write()
		vim.cmd.Start { binding[2] .. ';read' }
	end)
end

for _, binding in ipairs(runners) do
	vim.api.nvim_create_autocmd('FileType', {
		pattern = binding[1],
		callback = function()
			if type(binding[2]) == "table" then
				for _, r in ipairs(binding[2]) do
					set_keymap(r)
				end
			else
				set_keymap { '<F9>', binding[2] }
			end
		end
	})
end
