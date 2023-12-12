-- main.lua

local entities = require('entities')
local input = require('input')
local world = require('world')
local state = require('state')
local colors = require('colors')
local projectile_man = require('projectile-man')

love.graphics.setBackgroundColor(colors['grey'])

love.draw = function()
	for _, entity in ipairs(entities) do
		if entity.draw then entity:draw() end
	end
end

love.update = function(dt)
	if not state.paused and not state.game_over then
		for i, entity in ipairs(entities) do
			if entity.update then entity:update(dt) end
			projectile_man(entity, i)
		end
		world:update(dt)
	end
end

love.keypressed = function(key) input.press(key) end

love.focus = function(focused) input.toggle_focus(focused) end
