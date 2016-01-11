local vec2 = require "tools/vec2"

local function gen()
	local quads = {}
	for i = 1, 256/16 do
		table.insert(quads,vec2:new(16*i-16 + i,0))
	end
	return quads
end

return gen()