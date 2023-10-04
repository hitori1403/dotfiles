local awful = require 'awful'
local notify = require 'utils.notify'

notify = notify:new()

awesome.connect_signal('modules::volume', function()
	awful.spawn.easy_async('pactl list sinks', function(stdout)
		if stdout then
			local state

			if stdout:match('Mute: yes') then
				state = '[Muted]'
			else
				state = '[On]'
			end

			notify:send(state .. ' ' .. stdout:match('Volume: front%-left: %d+ /%s+(%d+%%)'), 'VOLUME')
		else
			notify:send('Not responding!')
		end
	end)
end)
