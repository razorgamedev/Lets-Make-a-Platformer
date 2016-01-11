local Renderer = {}

local numLayers = 5

function Renderer:load()
	self.renderers = {}
	for i = 1,numLayers do
		self.renderers[i] = {}
	end
end

function Renderer:addRenderer(obj,layer)
	local l = layer or 3
	table.insert(self.renderers[l],obj)
end

-- rem
function Renderer:removeRenderer(obj)
	for i = #self.renderers,1,-1 do
		if self.renderers[i] == obj then
			table.remove(self.renderers,i)
			return
		end
	end
end
-- end rem

function Renderer:draw()
	for layer = 1,#self.renderers do
		for i = 1,#self.renderers[layer] do
			local obj = self.renderers[layer][i]
			obj:draw(dt)
		end
	end
end

return Renderer