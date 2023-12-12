-- entities/player.lua

local state = require('state')
local sound = require('sound')
local world = require('world')
local colors = require('colors')	

local RIGHT_ANGLE = math.rad(90)

local rotate = function(entity)
  local angle = entity.body:getAngle()
  if angle == 0 then 
    entity.body:setAngle(RIGHT_ANGLE)
  else
    entity.body:setAngle(0)
  end
end

return function()
  local window_width, window_height = love.window.getMode()
  local width, height = 50, 120
  local width_half, height_half = width / 2, height / 2
  local pos_x, pos_y = 300-54, 300
  
  local entity = {}

  entity.body = love.physics.newBody(world, pos_x, pos_y, "dynamic")
  entity.shape = love.physics.newRectangleShape(width, height)
  entity.fixture = love.physics.newFixture(entity.body, entity.shape)
	entity.fixture:setUserData(entity)
	
  entity.draw = function(self)
    love.graphics.setColor(colors['black'])
    love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
  end

  local getHalf = function(angle)
    if angle == 0 then
      return height_half
    else
      return width_half
    end
  end

  local collision_bottom = false
  local collision_top = false
  entity.update = function(self)
  -- FIXME: when entity is rotating when at bottom/top, it goes out of bounds
  -- make it so that it checks if rotation will make entity out of bounds before rotation
    if state.rotate then
      state.rotate = false
      rotate(self)
      sound.effect_move()
    end

    if state.up then
      local newY = self.body:getY() - 30
      local half = getHalf(self.body:getAngle())
      
      if newY - half >= 0 then
        state.up = false
        collision_top = false
        self.body:setY(self.body:getY() - 30)
        sound.effect_move()
      else
        if not collision_top then 
          sound.effect_collision() 
          collision_top = true
        end
      end
    end

    if state.down then
      local newY = self.body:getY() + 30
      local half = getHalf(self.body:getAngle())
      
      if newY + half <= window_height then
        state.down = false
        collision_bottom = false
        self.body:setY(self.body:getY() + 30)
        sound.effect_move()
      else
        if not collision_bottom then 
          sound.effect_collision() 
          collision_bottom = true
        end
      end
    end
  end
  
  return entity
end
