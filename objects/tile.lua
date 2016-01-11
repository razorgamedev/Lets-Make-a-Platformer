local rect = require "objects/rect"

local Tile = {}

function Tile:new(x,y,w,h,img,quad,props)
	local tile = rect:new(x,y,w,h)
	tile.img = img
	tile.quad = quad
	tile.props = props
	return tile
end

return Tile