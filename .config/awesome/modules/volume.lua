local awful = require('awful')
local naughty = require('naughty')
local beautiful = require('beautiful')

local id
local waifu = beautiful.get_random_waifu()

local notify = function(text)
	id = naughty.notify({
		title = 'VOLUME',
		text = text,
		icon = waifu,
		replaces_id = id
	}).id
end

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
