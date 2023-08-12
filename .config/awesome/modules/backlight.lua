local awful = require('awful')
local naughty = require("naughty")
local beautiful = require("beautiful")

local id
local waifu = beautiful.get_random_waifu()

local notify = function(text)
	id = naughty.notify({
		title = 'BRIGHTNESS',
		text = text,
		icon = waifu,
		replaces_id = id
	}).id
end

awesome.connect_signal('modules::backlight', function()
	awful.spawn.easy_async('xbacklight -get', function(stdout)
		notify(stdout:sub(1, -2) .. '%')
	end)
end)
