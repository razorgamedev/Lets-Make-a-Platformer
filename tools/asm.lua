local ASM = {}

function ASM:load()
	self.assets = {}
end

function ASM:add(asset,id)
	local a = {asset = asset,id = id}
	table.insert(self.assets,a)
end

function ASM:get(id)
	for i,a in ipairs(self.assets) do
		if a.id == id then
			return a.asset
		end
	end
end

return ASM