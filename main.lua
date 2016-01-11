tlm 		= require "tools/tlm"

gameLoop 	= require "tools/gameLoop"
renderer 	= require "tools/renderer"
obm 		= require "tools/obm"
asm 		= require "tools/asm"

Width 		= love.graphics.getWidth()
Height      = love.graphics.getHeight()

require "tools/camera"

GAMETIME  = 0
TILE_SIZE = 16
MAP_SIZE  = 64

local delta_time = {}
local av_dt      = 0.016
local sample     = 10

function love.load()
	asm:load()
	asm:add(love.graphics.newImage("assets/images/tile_sheet_1.png"),"tiles")

	gameLoop:load()
	renderer:load()
	tlm:load()
	obm:load()

	tlm:loadmap("level_1")

	camera.scale.x = .3
	camera.scale.y = .3

	obm:add(require("objects/player"):new(128,64))
end

local pop, push = table.remove,
			      table.insert

function love.update(dt)

	push(delta_time,dt)
	if #delta_time > sample then
		local av 	= 0
		local num 	= #delta_time

		for i = #delta_time,1,-1 do
			av = av + delta_time[i]
			pop(delta_time,i)
		end

		av_dt = av / num
	end

	gameLoop:update(av_dt)
	GAMETIME = GAMETIME + av_dt

end

function love.draw()
	camera:set()
	renderer:draw()
	camera:unset()
end