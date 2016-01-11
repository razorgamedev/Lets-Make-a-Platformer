local Vec2 = {}

function Vec2:new(x,y)
	local vec2 = {}

	vec2.x = x or 0
	vec2.y = y or 0

	function vec2:move(nx,ny)
		self.x = self.x + nx
		self.y = self.y + ny
	end

	return vec2
end

return Vec2