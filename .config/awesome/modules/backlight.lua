local awful = require 'awful'
local notify = require 'utils.notify'

notify = notify:new()

awesome.connect_signal('modules::backlight', function()
	awful.spawn.easy_async('xbacklight -get', function(stdout)
		notify:send(stdout:sub(1, -2) .. '%', 'BRIGHTNESS')
	end)
end)
