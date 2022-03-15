local dpi		= require('beautiful.xresources').apply_dpi
local wibox		= require("wibox")
local gears		= require('gears')
local beautiful = require('beautiful')

local icon_widget = wibox.widget {
	fixed_height = 15,
	fixed_width = 15,
	widget = wibox.widget.imagebox
}

local value_widget = wibox.widget {
	text = 'abc',
	widget = wibox.widget.textbox
}

local battery_widget = {
	{
		icon_widget,
		valign = 'center',
		halign = 'center',
		widget = wibox.container.place
	},
	value_widget,
	spacing = dpi(7),
	layout = wibox.layout.fixed.horizontal
}

awesome.connect_signal('evil::battery', function (battery)
	value_widget.text = battery .. '%'
end)

awesome.connect_signal('evil::charger', function (plugged)
	local icon
	if plugged then
		icon = beautiful.icons.battery_charging
	else
		icon = beautiful.icons.battery
	end
	icon_widget.image = gears.color.recolor_image(icon, '#61c766')
end)

return battery_widget
