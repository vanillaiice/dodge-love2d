-- entities/arrow.lua

local state = require('state')
local world = require('world')
local colors = require('colors')

return function(pos_x, pos_y, velocity_x, velocity_y)
  --local window_width, window_height = love.window.getMode()
  --local width, height = window_width / 7, window_height / 50
  local width, height = 71, 10
  
  local entity = {}

  entity.body = love.physics.newBody(world, pos_x, pos_y, "kinematic")
  entity.shape = love.physics.newRectangleShape(width, height)
  entity.fixture = love.physics.newFixture(entity.body, entity.shape)
	entity.fixture:setUserData(entity)
	
  entity.draw = function(self)
    love.graphics.setColor(colors['white'])
    love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
  end

  entity.update = function(self, dt)
    self.body:setLinearVelocity(velocity_x, velocity_y)
  end

  entity.begin_contact = function(self)
    state.game_over = true
  end

  entity.type = 'proj'

  return entity
end
