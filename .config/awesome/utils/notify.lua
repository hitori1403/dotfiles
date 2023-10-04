local naughty = require 'naughty'
local beautiful = require 'beautiful'

local M = {}

function M:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.id = nil
	o.icon = beautiful.get_random_waifu()
	return o
end

function M:send(text, title)
	self.id = naughty.notify({
		title = title,
		text = text,
		icon = self.icon,
		replaces_id = self.id
	}).id
end

return M
