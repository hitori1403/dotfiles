local awful = require 'awful'
local notify = require 'utils.notify'

notify = notify:new()

awesome.connect_signal('modules::backlight', function()
	awful.spawn.easy_async('brightnessctl', function(stdout)
		local percent = string.match(stdout, "Current brightness:%s*%d+ %((%d+%%)%)")
		notify:send(percent, 'BRIGHTNESS')
	end)
end)
