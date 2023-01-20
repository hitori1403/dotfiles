local awful	= require('awful')
local naughty	= require('naughty')
local beautiful = require('beautiful')

local id
local notify = function (text)
	id = naughty.notify({
		title = '[ TOUCHPAD ]',
		text = text,
		icon = beautiful.get_random_waifu(),
		replaces_id = id
	}).id
end

-- Control behavior of touchpad
-- @param {string} mode - Value can be 'enable', 'disable', 'toggle' or 'auto'

local touchpad = function (value)
	local options = {'disable', 'enable', 'toggle', 'auto'}

	local mode
	for i, v in pairs(options) do
		if value == v then
			mode = i - 1
			break
		end
	end

	if mode == nil then
		return
	end

	awful.spawn.easy_async_with_shell([[xinput list | grep -Eio '(touchpad|glidepoint)\s*id=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}']],
		function (stdout)
			local device_id = stdout

			if mode == 2 then
				local fd = io.popen('xinput list-props ' .. device_id, 'r')
				local state = fd:read('*a')
				fd:close()
				mode = 1 - tonumber(state:match('Device Enabled %(%d+%):%s(%d)'))
			elseif mode == 3 then	
				local fd = io.popen('ls /dev/input/by-id/*-mouse 2> /dev/null')
				local mouse = fd:read('*a')
				fd:close()
				mode = mouse == '' and 1 or 0
			end

			if mode == 0 then
				awful.spawn(string.format('xinput disable %s', device_id))
				notify('Touchpad is now disable')
			else
				awful.spawn(string.format('xinput enable %s', device_id))
				notify('Touchpad is now enable')
			end
		end
	)
	end

awesome.connect_signal('modules::touchpad',
	function (mode)
		touchpad(mode)
	end
)
