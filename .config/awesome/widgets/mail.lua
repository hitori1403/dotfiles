local beautiful = require('beautiful')
local gears = require('gears')
local wibox = require('wibox')
local dpi = require('beautiful.xresources').apply_dpi

local value_widget = wibox.widget {
	markup = '0',
	widget = wibox.widget.textbox
}

local mail_widget = wibox.widget {
	{
		{
		image = gears.color.recolor_image(beautiful.icons.mail, '#6f97ec'),
		forced_height = 15,
		forced_width = 15,
		widget = wibox.widget.imagebox
		},
		valign = "center",
        halign = "center",
        widget = wibox.container.place,
	},
	spacing = dpi(7),
	value_widget,
	layout = wibox.layout.fixed.horizontal
}

awesome.connect_signal('evil::mail', function (total_mails)
	value_widget.markup = total_mails
end)

mail_widget:connect_signal('button::press', function ()
	awesome.emit_signal('evil::mail_showall')
end)

return mail_widget
