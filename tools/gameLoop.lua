local GameLoop = {}

function GameLoop:load()
	self.tickers = {}
end

function GameLoop:addLoop(obj)
	table.insert(self.tickers,obj)
end

-- rem
function GameLoop:removeLoop(obj)
	for i = #self.tickers,1,-1 do
		if self.tickers[i] == obj then
			table.remove(self.tickers,i)
			return
		end
	end
end
-- end rem

function GameLoop:update(dt)
	for i = 1,#self.tickers do
		local obj = self.tickers[i]
		obj:tick(dt)
	end
end

return GameLoop