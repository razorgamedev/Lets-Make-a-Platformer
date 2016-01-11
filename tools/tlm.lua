local Tlm = {}

local quad = love.graphics.newQuad

local quads = {}

local floor = math.floor
function gen_quads()
	for i = 1, floor(256/17) do
		for j = 1, floor(256/17) do
			table.insert(quads,quad(17*j-17,17*i-17,16,16,256,256))
		end
	end
end
gen_quads()

function tile(x,y,w,h,quad)
	local tile = {}

	tile.pos = require("tools/vec2"):new(x,y)
	tile.size = require("tools/vec2"):new(w,h)
	tile.quad = quad

	return tile
end

function Tlm:load()
	self.tiles = {}
	self.img = asm:get("tiles")
	self.img:setFilter("nearest","nearest")

	renderer:addRenderer(self)
end

function Tlm:draw()

	for layer = 1,#self.tiles do
		for i = 1,64 do
			for j = 1,64 do 

				if self.tiles[layer][i][j] ~= nil then
					local tile = self.tiles[layer][i][j]
					love.graphics.draw(self.img,tile.quad,tile.pos.x,tile.pos.y)
				end

			end
		end
	end
end

function Tlm:is_solid_at_pos(x,y)
	local solids = self.tiles[3]

	if solids[y][x] ~= nil then
		return true
	end
	return false
end

function Tlm:loadmap(mapname)
	local map = require ("assets/maps/"..mapname)

	for layer = 1,#map.layers do
		self.tiles[layer] = {}
		for i = 1,map.height do
			self.tiles[layer][i] = {}
		end
	end

	for layer = 1,#map.layers do
		local data = map.layers[layer].data
		local prop = map.layers[layer].properties

		print(prop["solid"])

		for y = 1,map.height do
			for x = 1,map.width do

				local index = (y*map.height +(x-1)-map.width)+1

				if data[index] ~= 0 then
					local q = quads[data[index]]
					self.tiles[layer][y][x] = tile(16*x-16,16*y-16,16,16,q)

				end

			end
		end
	end

end

function Tlm:destroy()

end

return Tlm