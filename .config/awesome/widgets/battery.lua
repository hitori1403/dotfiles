local os = require 'os'
local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
local notify = require 'utils.notify'

notify = notify:new()

local ac_online, bat_perc
local hook_notify = true
local last_notify_time = os.time()

widget = wibox.widget {
	{
		id = 'icon',
		text = '\u{e1a6}',
		font = beautiful.font_icon,
		widget = wibox.widget.textbox
	},
	{
		id = 'value',
		widget = wibox.widget.textbox
	},
	layout = wibox.layout.fixed.horizontal
}

awesome.connect_signal('battery::charger', function(online)
	ac_online = online

	if online then
		notify:send('AC adapter is connected!')
	else
		notify:send('AC adapter is disconnected!')
	end

	if bat_perc then
		awesome.emit_signal('battery::battery', bat_perc)
	end
end)

awesome.connect_signal('battery::battery', function(perc)
	bat_perc = perc
	widget.value:set_markup(perc .. '%')

	if ac_online then
		widget.icon:set_markup('\u{e1a3}')
	else
		if perc <= 10 and (os.difftime(os.time(), last_notify_time) >= 300 or hook_notify) then
			notify:send("Battery low. Plug the cable!")

			last_notify_time = os.time()
			hook_notify = false
		end

		if perc <= 12.5 then
			widget.icon:set_markup('\u{ebdc}')
		elseif perc <= 25 then
			widget.icon:set_markup('\u{ebd9}')
		elseif perc <= 37.5 then
			widget.icon:set_markup('\u{ebe0}')
		elseif perc <= 50 then
			widget.icon:set_markup('\u{ebdd}')
		elseif perc <= 62.5 then
			widget.icon:set_markup('\u{ebe2}')
		elseif perc <= 75 then
			widget.icon:set_markup('\u{ebd4}')
		elseif perc <= 87.5 then
			widget.icon:set_markup('\u{ebd2}')
		else
			widget.icon:set_markup('\u{e1a4}')
		end
	end
end)

awful.spawn.easy_async_with_shell("find /sys/class/power_supply/BAT?/capacity -print -quit",
	function(battery_file, _, __, exit_code)
		if exit_code ~= 0 then
			return
		end

		awful.widget.watch('cat ' .. battery_file, 60, function(_, stdout)
			awesome.emit_signal('battery::battery', tonumber(stdout))
		end)
	end)

awful.spawn.easy_async_with_shell("find /sys/class/power_supply/ADP?/online -print -quit",
	function(charger_file, _, __, exit_code)
		if exit_code ~= 0 then
			return
		end

		local emit_charger_info = function()
			awful.spawn.easy_async_with_shell("cat " .. charger_file, function(out)
				awesome.emit_signal("battery::charger", tonumber(out) == 1)
			end)
		end

		-- Run once to initialize widget
		emit_charger_info()

		-- Kill old acpi_listen process
		awful.spawn.easy_async('pkill -x acpi_listen', function()
			-- Update battery widget with each line printed
			awful.spawn.with_line_callback([[sh -c 'acpi_listen | grep --line-buffered ac_adapter']], {
				stdout = function(_)
					emit_charger_info()
				end
			})
		end)
	end)

return widget
