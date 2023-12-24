local awful = require 'awful'
local notify = require 'utils.notify'

notify = notify:new()

awesome.connect_signal('modules::volume', function()
	awful.spawn.easy_async('pactl get-default-sink', function(default_sink)
		if default_sink then
			local state

			if io.popen(string.format('pactl get-sink-mute %s', default_sink)):read('*all'):match('Mute: yes') then
				state = '[Muted]'
			else
				state = '[On]'
			end

			notify:send(
				state ..
				' ' ..
				io.popen(string.format('pactl get-sink-volume %s', default_sink)):read('*all'):match(
					'Volume: front%-left: %d+ /%s+(%d+%%)'), 'VOLUME')
		else
			notify:send('Not responding!')
		end
	end)
end)
