local awful = require('awful')
local naughty = require('naughty')
local beautiful = require('beautiful')

local id
local notify = function(text)
	id = naughty.notify({
		text = text,
		icon = beautiful.get_random_waifu(),
		replaces_id = id
	}).id
end

-- Control behavior of touchpad
-- @param {string} mode - Value can be 'enable', 'disable', 'toggle' or 'auto'

local touchpad = function(value)
	local options = { 'disable', 'enable', 'toggle', 'auto' }

	local control_touchpad = function(device_id, mode)
		if mode == 0 then
			awful.spawn(string.format('xinput disable %s', device_id))
			notify('Touchpad is now disable')
		else
			awful.spawn(string.format('xinput enable %s', device_id))
			notify('Touchpad is now enable')
		end
	end

	for mode, v in pairs(options) do
		if value == v then
			awful.spawn.easy_async_with_shell(
				[[xinput list | grep -Eio '(touchpad|glidepoint)\s*id=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}']],
				function(device_id)
					if mode == 3 then
						awful.spawn.easy_async('xinput list-props ' .. device_id, function(state)
							control_touchpad(device_id, 1 - tonumber(state:match('Device Enabled %(%d+%):%s(%d)')))
						end)
					elseif mode == 4 then
						awful.spawn.easy_async_with_shell('find /dev/input/by-id/*-mouse -quit',
							function(_, __, ___, exit_code)
								control_touchpad(device_id, exit_code)
							end)
					else
						control_touchpad(device_id, mode - 1)
					end
				end
			)
		end
	end
end

awesome.connect_signal('modules::touchpad', function(mode)
	touchpad(mode)
end)
