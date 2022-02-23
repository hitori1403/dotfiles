local wibox = require("wibox")
local dpi = require('beautiful.xresources').apply_dpi
local gears = require('gears')

local icon_widget = wibox.widget {
	fixed_height = 15,
	fixed_width = 15,
	widget = wibox.widget.imagebox
}

local value_widget = wibox.widget {
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

awesome.connect_signal('evil::battery', function(icon, value)
	icon_widget.image = gears.color.recolor_image(icon, '#61c766')
	value_widget.text = value .. '%'
end)

return battery_widget
