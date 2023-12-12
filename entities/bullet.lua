-- entities/bullet.lua

local state = require('state')
local world = require('world')
local colors = require('colors')

return function(pos_x, pos_y, radius, velocity_x, velocity_y)
  local entity = {}

  entity.body = love.physics.newBody(world, pos_x, pos_y, "kinematic")
  entity.shape = love.physics.newCircleShape(radius)
  entity.fixture = love.physics.newFixture(entity.body, entity.shape)
	entity.fixture:setUserData(entity)
	
  entity.draw = function(self)
		local self_x, self_y = self.body:getWorldCenter()
    love.graphics.setColor(colors['gold'])
		love.graphics.circle('fill', self_x, self_y, self.shape:getRadius())
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
