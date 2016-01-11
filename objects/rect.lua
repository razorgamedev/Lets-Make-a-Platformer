local vec2 = require "tools/vec2"

local Rect = {}

function Rect:new(x,y,w,h)
	local rect = {}

	rect.pos = vec2:new(x,y)
	rect.size = vec2:new(w,h)

	function rect:midX()
		return self.pos.x + self.size.x/2
	end

	function rect:midY()
		return self.pos.y + self.size.y/2
	end

	function rect:midXY()
		return self:midX(),self:midY()
	end

	return rect
end

return Rect