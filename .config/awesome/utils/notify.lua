local naughty = require 'naughty'
local beautiful = require 'beautiful'

local id

return function(text, title)
	id = naughty.notify({
		title = title,
		text = text,
		icon = beautiful.get_random_waifu(),
		replaces_id = id
	}).id
end
