local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
local json = require 'libs.json'
local notify = require 'utils.notify'


local last_price = 0

local widget = wibox.widget {
	{
		id = 'icon',
		text = '\u{ebc5}',
		font = beautiful.font_icon,
		widget = wibox.widget.textbox
	},
	{
		id = 'value',
		text = '?',
		widget = wibox.widget.textbox,
		color = beautiful.red,
	},
	layout = wibox.layout.fixed.horizontal
}

awesome.connect_signal('coin::bitcoin', function(price)
	local color = beautiful.fg_normal
	if price > last_price then
		color = beautiful.green
	elseif price < last_price then
		color = beautiful.red
	end
	last_price = price
	widget.value:set_markup(string.format("<span foreground='%s'>%s</span>", color, price))
end)

awful.spawn.with_line_callback("coin-price", {
	stdout = function(output)
		local prices = json.decode(output)
		awesome.emit_signal("coin::bitcoin", tonumber(prices['bitcoin']))
	end
})

return widget
