camera = 
{
	pos = require("tools/vec2"):new(0,0),
	size = require("tools/vec2"):new(0,0),
	scale = require("tools/vec2"):new(1,1),
	rot = 0
}

local lg 		= love.graphics
local pop 		= lg.pop
local trans 	= lg.translate
local rotate 	= lg.rotate
local scale 	= lg.scale
local push 		= lg.push

function camera:set()
	push()
	trans(-self.pos.x,-self.pos.y)
	rotate(-self.rot)
	scale(1 / self.scale.x,1 / self.scale.y)
end

function camera:goto_point(pos)
	self.pos.x = pos.x * (1/self.scale.x) - Width / 2
	self.pos.y = pos.y * (1/self.scale.x) - Height / 2
end

function camera:unset()
	pop()
end

return camera