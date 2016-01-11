local Player = {}

require "tools/camera"
require "tools/physics_helper"
require "world_physics/world_physics"

local rect = require "objects/rect"
local floor = math.floor

local tiles = tlm.tiles[3]

local quad  = love.graphics.newQuad
local anim_data = {
	quad(0,0,8,16,128,16),
	quad(9,0,8,16,128,16),
	quad(18,0,8,16,128,16),
}
local image = love.graphics.newImage("assets/images/Player_Sheet.png")
image:setFilter("nearest","nearest")

function Player:new(x,y)

	--x,y,w,h,img,quad,id
	local player = require("objects/entity"):new(x,y,16,16,nil,nil,"player")

	function player:load()
		gameLoop:addLoop(self)
		renderer:addRenderer(self)

		init_physics(self,500)

		-- rem
		self.animation = require("tools/animation"):new(
				image,
				{
					{ -- idle
						anim_data[1]
					},
					{ -- walk
						anim_data[2],
						anim_data[3],
						anim_data[2]
					},
				},
				0.2
			)

		self.animation:play()
		-- end rem
	end

	local key = love.keyboard.isDown

	function player:tick(dt)
		camera:goto_point(self.pos)

		self.animation:set_animation(1)

		-- apply gravity
		apply_gravity(self,dt)

		if key("left") then
			self.animation:set_animation(2)
			self.dir.x = -1
			self.vel.x = 200
		end

		if key("right") then
			self.animation:set_animation(2)
			self.dir.x = 1
			self.vel.x = 200
		end

		-- collisions
		update_physics(self,tiles,dt)
		-- 

		if key("z") then
			physics_jump(self)
		end

		self.pos.x = self.pos.x + (self.vel.x * dt) * self.dir.x
		self.pos.y = self.pos.y + (self.vel.y * dt) * self.dir.y

		self.vel.x = self.vel.x * (1-dt*12)

		self.animation:update(dt)
	end

	function player:draw()

		self.animation:draw({self.pos.x,self.pos.y})
		--love.graphics.rectangle("fill",self.pos.x,self.pos.y,self.size.x,self.size.y)
	end

	return player
end

return Player