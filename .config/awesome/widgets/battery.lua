local lain = require 'lain'
local gears = require 'gears'
local wibox = require 'wibox'
local awful = require 'awful'
local naughty = require 'naughty'
local beautiful = require 'beautiful'

local id
local notify = function (text)
	id = naughty.notify({
		title = '[ BATTERY ]',
		text = text,
		icon = beautiful.get_random_waifu(),
		replaces_id = id
	}).id
end

local baticon = wibox.widget {
	font = beautiful.font_icon,
	widget = wibox.widget.textbox
}

local hook_notify = false

local bat = lain.widget.bat {
	notify = 'off',
	timeout = 60,
	settings = function ()
		if bat_now.status and bat_now.status ~= 'N/A' then
			if bat_now.ac_status == 1 then
				baticon:set_markup('\u{e1a3}')
				if hook_notify then
					notify('AC adapter is connected')
					hook_notify = false
				end
			else
				if bat_now.perc <= 12.5 then
					baticon:set_markup('\u{ebdc}')
				elseif bat_now.perc <= 25 then
					baticon:set_markup('\u{ebd9}')
				elseif bat_now.perc <= 37.5 then
					baticon:set_markup('\u{ebe0}')
				elseif bat_now.perc <= 50 then
					baticon:set_markup('\u{ebdd}')
				elseif bat_now.perc <= 62.5 then
					baticon:set_markup('\u{ebe2}')
				elseif bat_now.perc <= 75 then
					baticon:set_markup('\u{ebd4}')
				elseif bat_now.perc <= 87.5 then
					baticon:set_markup('\u{ebd2}')
				else
					baticon:set_markup('\u{e1a4}')
				end
				if hook_notify then
					notify('AC adapter is disconnected')
					hook_notify = false
				end
			end
			widget:set_markup(bat_now.perc .. '%')
		else
			baticon:set_markup('\u{e1a6}')
			widget:set_markup(bat_now.perc)
		end
	end
}

-- initial
gears.timer {
	timeout = 1,
	autostart = true,
	single_shot = true,
	callback = function ()
		bat.update()
	end
}

-- kill old acpi_listen process
awful.spawn.easy_async('pkill -x acpi_listen', function ()
	-- update battery widget with each line printed
	awful.spawn.with_line_callback([[sh -c 'acpi_listen | grep --line-buffered ac_adapter']], {
		stdout = function (_)
			hook_notify = true
			bat.update()
		end
	})
end)

local widget = {
	baticon,
	bat.widget,
	layout = wibox.layout.fixed.horizontal
}

return widget
