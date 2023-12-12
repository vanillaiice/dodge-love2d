-- entities/text/score.lua

local state = require('state')
local colors = require('colors')

return function()
  local entity = {}
  
  entity.draw = function()
    love.graphics.setColor(colors['black'])
    love.graphics.print(
      state.score,
      5,
      0,
      0,
      2,
      2
    )
  end

  return entity
end
