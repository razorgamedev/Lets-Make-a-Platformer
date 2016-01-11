local Zombie = {}

require "tools/camera"
require "tools/physics_helper"
require "world_physics/world_physics"

local rect = require "objects/rect"
local floor = math.floor
local tiles = tlm.tiles[3]

function Zombie:new(x,y)
	local zombie = require("objects/entity"):new(x,y,16,16,nil,nil,"enemy")

	function zombie:load()
		gameLoop:addLoop(self)
		renderer:addRenderer(self)

		init_physics(self,500)
	end

	function zombie:tick(dt)
		apply_gravity(self,dt)


		local player = obm:get_obj_by_id(self,"player")
		if self.on_ground then
			if self.pos.x < player.pos.x then
				self.vel.x = 150
			else
				self.vel.x = -50
			end
		end

		if math.random(1,10) == 1 then
			physics_jump(self)
		end

		-- collisions
		update_physics(self,tiles,dt)
		--

		local x_pos = floor(self.pos.x / TILE_SIZE)
		local y_pos = floor(self.pos.y / TILE_SIZE)+1

		if tlm:is_solid_at_pos(x_pos,y_pos) then
			physics_jump(self)
		end

		if tlm:is_solid_at_pos(x_pos+3,y_pos) then
			physics_jump(self)
		end

		if not tlm:is_solid_at_pos(x_pos+3,y_pos+1) then
			physics_jump(self)
		end

		if not tlm:is_solid_at_pos(x_pos,y_pos+1) then
			physics_jump(self)
		end

		self.pos.y = self.pos.y + self.vel.y * dt
		self.pos.x = self.pos.x + self.vel.x * dt
	end

	function zombie:draw()
		love.graphics.setColor(255,0,0)
		love.graphics.rectangle("fill",self.pos.x,self.pos.y,self.size.x,self.size.y)
		love.graphics.setColor(255,255,255)
	end

	return zombie
end

return Zombie