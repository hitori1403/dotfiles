local awful		= require('awful')
local beautiful = require('beautiful')
local naughty	= require('naughty')

local notify_critcal_battery = true

local show_battery_warning = function ()
	local notif
	notif = naughty.notify({
		title = '[ BATTERY ]',
		text = 'Your battery is not daijobu :<<',
		icon = beautiful.get_random_waifu(),
		timeout = 15,
		run = function ()
			notify_critcal_battery = false
			notif.die(naughty.notificationClosedReason.dismissedByUser)
		end
	})
end

local battery_update = function (status)
	local charger = status:match('Adapter %d+: (.*)'):sub(1, -2)
	local value = tonumber(status:match('(%d+)%%'))
	local icon = beautiful.icons.battery

	if charger == 'on-line' then
		icon = beautiful.icons.battery_charging
		if not notify_critcal_battery then
			notify_critcal_battery = true
		end
	elseif value < 10 and notify_critcal_battery then
			show_battery_warning()
	end

	awesome.emit_signal('evil::battery', icon, value)
end

awful.widget.watch('acpi -ab', 60, function (_, stdout)
	battery_update(stdout)
end)
