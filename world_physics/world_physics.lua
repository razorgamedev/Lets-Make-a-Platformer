local floor = math.floor

local rect = require "objects/rect"
local vec2 = require "tools/vec2"

function init_physics(obj,gravity)
	obj.on_ground = false
	obj.gravity   = gravity or 500
end

function apply_gravity(obj,dt)
	obj.vel.y = obj.vel.y + obj.gravity * dt
	obj.dir.y = 1
end

function physics_jump(obj)
	if obj.vel.y < 10 and obj.vel.y > -10 and obj.on_ground then
		obj.vel.y = -obj.gravity * .4
		obj.on_ground = false
	end
end

function update_physics(obj,tiles,dt)
	local x = floor(obj.pos.x / 16) -1
	local y = floor(obj.pos.y / 16) -1
	local w = 3
	local h = 3

	if x < 1 then x = 1 end
	if y < 1 then y = 1 end

	for i = y,y+h do
		for j = x,x+w do

			if i > MAP_SIZE then i = MAP_SIZE end
			if j > MAP_SIZE then j = MAP_SIZE end 

			local tile = tiles[i][j]
			if tile == nil then goto cont end

			-- change
			local box = rect:new(obj.pos.x + (obj.vel.x * dt * obj.dir.x),obj.pos.y + obj.vel.y * dt,obj.size.x,obj.size.y)
			
			local coll, rect = rect_collision(box,tile)

			if coll then
				obj.vel.y = 0
				obj.dir.y = 0

				-- y coll
				if obj.pos.y + obj.size.y / 2 < rect.pos.y + rect.size.y / 2 then

					if box.pos.y + box.size.y > rect.pos.y and
					   obj.pos.y + obj.size.y < rect.pos.y + 8 then

					   obj.on_ground = true
					   obj.pos.y = rect.pos.y - obj.size.y
					end

				else -- remove for video
					if obj.pos.y > rect.pos.y + rect.size.y-8 then
						obj.vel.y = 0
						obj.pos.y = rect.pos.y + rect.size.y + 1

						goto skip_x
					end
				end
				--

				-- x coll
				if obj.pos.x + obj.size.x / 2 < rect.pos.x + rect.size.x / 2 then
			
					if box.pos.x + box.size.x > rect.pos.x and
					   obj.pos.y + obj.size.y > rect.pos.y then

					    obj.vel.x = 0
					    obj.dir.x = 0

					    obj.pos.x = rect.pos.x - obj.size.x
					end 

				else

					if box.pos.x < rect.pos.x + rect.size.x and
					   obj.pos.y + obj.size.y > rect.pos.y then

					   	obj.vel.x = 0
					   	obj.dir.x = 0

					   	obj.pos.x = rect.pos.x + rect.size.x
					end

				end

				--
				::skip_x::
			end

			::cont::
		end
	end
end