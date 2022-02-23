local beautiful = require('beautiful')
local gears = require('gears')
local wibox = require('wibox')

local date_widget = wibox.widget {
	{
		{
			image = gears.color.recolor_image(beautiful.icons.clock, '#ff6565'),
			forced_height = 15,
			forced_width = 15,
			widget = wibox.widget.imagebox
		},
	    valign = "center",
        halign = "center",
        widget = wibox.container.place,
	},
	wibox.widget.textclock(),
	layout = wibox.layout.fixed.horizontal
}

return date_widget
