local awful = require 'awful'
local notify = require 'utils.notify'

notify = notify:new()

awesome.connect_signal('battery::charger', function(online)
	local profile
	if online then
		profile = 'balanced'
	else
		profile = 'power-saver'
	end

	awful.spawn.easy_async('powerprofilesctl set ' .. profile, function()
		notify:send('Power profile is set to ' .. profile)
	end)
end)
