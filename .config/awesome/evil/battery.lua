-- Battery script inspired from elenapan
-- Provides:
-- evil::battery
--		{int} percentage
-- evil::charger
--		{boolean} plugged

local awful = require('awful')
local naughty = require('naughty')
local inspect = require('lib.inspect')

local update_interval = 30

-- Subcribe to power supply status changes with acpi_listen
local charger_script = "sh -c 'acpi_listen | grep --line-buffered ac_adapter'"

-- First get battery file percentage
-- If there are multiple, only get the first one
-- TODO support multiple batteries
awful.spawn.easy_async_with_shell("sh -c 'out=\"$(find /sys/class/power_supply/BAT?/capacity)\" && (echo $out | head -1) || false'", function (battery_file, _, __, exit_code)
	-- No battery file found
	
	if exit_code ~= 0 then
		return
	end
	
	-- Periodically get battery info
	awful.widget.watch('cat ' .. battery_file, update_interval, function (_, stdout)
		awesome.emit_signal('evil::battery', tonumber(stdout))
	end)
end)

-- First get charger file path
awful.spawn.easy_async_with_shell("sh -c 'out=\"$(find /sys/class/power_supply/ADP?/online)\" && (echo $out | head -1) || false'", function (charger_file, _, __, exit_code)
	-- No charger file found
	if exit_code ~= 0 then
		return
	end

	-- Then initialize function that emits charger info
	local emit_charger_info = function ()
		awful.spawn.easy_async('cat ' .. charger_file, function (stdout)
			awesome.emit_signal('evil::charger', tonumber(stdout) == 1)
		end)
	end

	-- Run once to initialize widget
	emit_charger_info()

	-- Kill old acpi_listen process
	awful.spawn.easy_async('pkill -x acpi_listen', function ()
		-- Update chager status with each line printed
		awful.spawn.with_line_callback(charger_script, {
			stdout = function (_)
				emit_charger_info()
			end
		})
	end)
end)
