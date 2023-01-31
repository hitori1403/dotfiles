local naughty	= require("naughty")
local beautiful = require("beautiful")
local awful	= require('awful')

local id
local waifu = beautiful.get_random_waifu()

local send_notification = function (text)
	id = naughty.notify({
		title = '[ BRIGHTNESS ]',
		text = text,
		icon = waifu,
		replaces_id = id
	}).id
end

awesome.connect_signal('modules::backlight',
	function ()
		awful.spawn.easy_async('light -G',
			function (stdout)
				send_notification(stdout:sub(1, -2) .. '%')
			end
		)
	end
)
