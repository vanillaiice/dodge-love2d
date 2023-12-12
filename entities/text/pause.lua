-- entities/text/pause.lua

local state = require('state')
local colors = require('colors')
local sound = require('sound')

return function()
	local window_width, window_height = love.window.getMode()
	
	local entity = {}

	local sound_played = false
	entity.draw = function(self)
		if state.paused and not state.game_over then
			if not sound_played then
				sound.effect_pause()
				sound_played = true
			end
			love.graphics.setColor(colors['green'])
			love.graphics.print(
				'PAUSED',
				math.floor(window_width / 2) - 75,
				math.floor(window_height / 2),
				0,
				3,
				3
			)
		else
			sound_played = false
		end
	end

	return entity
end
