-- entities/text/game-over.lua

local state = require('state')
local colors = require('colors')
local sound = require('sound')

return function()
  local window_width, window_height = love.window.getMode()

  local entity = {}

  local sound_played = false
  entity.draw = function()
    if state.game_over then
      if not sound_played then
        sound.effect_game_over()
        sound_played = true
      end
      love.graphics.setColor(colors['red'])
      love.graphics.print(
        'GAME OVER',
        math.floor(window_width / 2) - 100,
        math.floor(window_height / 2),
        0,
        3,
        3
      )
    end
  end

  return entity
end
