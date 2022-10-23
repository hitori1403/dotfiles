local awful		= require('awful')
local beautiful = require('beautiful')
local naughty	= require('naughty')

local notification_id

local send_notification = function (text)
	notification_id = naughty.notify({
		title = '[ TOUCHPAD ]',
		text = text,
		icon = beautiful.get_random_waifu(),
		replaces_id = notification_id
	}).id
end

awesome.connect_signal('modules::touchpad',

	-- Control behavior of touchpad
	-- @param {string} value - Value can be 'enable' or 'disable' or 'toggle'

	function (value)
		if value ~= 'enable' and value ~= 'disable' and value ~= 'toggle' then
			return
		end

		awful.spawn.easy_async_with_shell("xinput list | grep -Eio '(touchpad|glidepoint)\\s*id\\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'",
			function (stdout)
				local device_id = stdout

				if value == 'toggle' then
					local fd = io.popen('xinput list-props ' .. device_id, 'r')
					local state = fd:read('*a')
					fd:close()

					state = state:match('Device Enabled %(%d+%):%s(%d)')

					if state == '0' then
						value = 'enable'
					else
						value = 'disable'
					end
				end

				awful.spawn(string.format('xinput %s %s', value, device_id))
				send_notification(string.format('Your touchpad is now %s', value))
			end
		)
	end
)
