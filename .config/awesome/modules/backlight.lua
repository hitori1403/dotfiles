local awful = require 'awful'
local notify = require 'utils.notify'

awesome.connect_signal('modules::backlight', function()
	awful.spawn.easy_async('xbacklight -get', function(stdout)
		notify(stdout:sub(1, -2) .. '%')
	end)
end)
