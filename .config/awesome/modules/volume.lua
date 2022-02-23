local awful		= require('awful')
local beautiful = require('beautiful')
local naughty	= require('naughty')

local id
local waifu = beautiful.get_random_waifu()

local send_notification = function (text)
	id = naughty.notify({
		title = '[ VOLUME ]',
		text = text,
		icon = waifu,
		replaces_id = id
	}).id
end

awesome.connect_signal('modules::volume',
	function ()
		awful.spawn.easy_async('pactl list sinks',
			function (stdout)
				local state
				local percentage = stdout:match('Volume: front%-left: %d+ /%s+(%d+%%)')

				if stdout:match('Mute: yes') then
					state = '[Muted]'
				else
					state = '[On]'
				end

				send_notification(state .. ' ' .. percentage)
			end
		)
	end
)
