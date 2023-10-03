local awful = require 'awful'
local notify = require 'utils.notify'

awesome.connect_signal('modules::volume', function()
	awful.spawn.easy_async('pactl list sinks', function(stdout)
		if stdout then
			local state

			if stdout:match('Mute: yes') then
				state = '[Muted]'
			else
				state = '[On]'
			end

			notify(state .. ' ' .. stdout:match('Volume: front%-left: %d+ /%s+(%d+%%)'))
		else
			notify('Not responding!')
		end
	end)
end)
