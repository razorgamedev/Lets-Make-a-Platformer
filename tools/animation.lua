--[[
	a = {
		{quads}, --walk
		{quads}, -- idle
	}
]]

local gfx = love.graphics

return{
	new = function(self,image,animation,time)
	return{
		current_frame = 1,
		current_anim  = 1,
		image 		  = image,
		a 			  = animation,
		play		  = false,
		time          = time or 0.2,
		counter		  = 0,

		update = function(self,dt)
			if self.play then
				self.counter = self.counter + dt
				if self.counter >= self.time then
					self.counter = 0
					self.current_frame = self.current_frame + 1
				end

				if self.current_frame > #self.a[self.current_anim] then
					self.current_frame = 1
				end
			else

			end
		end,

		play   = function(self)
			self.play = true
		end,
		stop   = function(self)
			self.play = false
		end,

		set_animation = function(self,anim)
			if anim > #self.a then error("there is no animation: "..anim); return end
			self.current_anim = anim
		end,

		draw = function(self,data)
			gfx.draw(self.image,self.a[self.current_anim][self.current_frame],data[1],data[2])
		end,	

	}
	end,
}