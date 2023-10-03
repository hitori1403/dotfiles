local awful = require 'awful'
local notify = require 'utils.notify'

awesome.connect_signal('battery::charger', function(online)
	local profile
	if online then
		profile = 'balanced'
	else
		profile = 'power-saver'
	end

	awful.spawn.easy_async('powerprofilesctl set ' .. profile, function()
		notify('Power profile is set to ' .. profile)
	end)
end)
