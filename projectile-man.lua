-- projectile-man.lua

local state = require('state')
local sound = require('sound')
local entities = require('entities')
local arrow = require('entities/arrow')
local bullet = require('entities/bullet')

local MAX_PROJ = 10
local SPAWN_INTERVAL = 0.5
local PROJ_LOWER = 1
local PROJ_UPPER = 2
local DIRECTION_LOWER = 1
local DIRECTION_UPPER = 4
local MIN_VELOCITY = 200
local MAX_VELOCITY = 300
local MIN_POS_Y = 10
local MAX_POS_Y = 590
local SPAWN_POS_X_LEFT = -10
local SPAWN_POS_X_RIGHT = 510
local SPAWN_POS_Y_DOWN = 610
local SPAWN_POS_Y_UP = -10
local SPAWN_POS_X_MIDDLE_LEFT = 210
local SPAWN_POS_X_MIDDLE_RIGHT = 280
local DESTROY_POS_X_LEFT = -20
local DESTROY_POS_X_RIGHT = 520
local DESTROY_POS_Y_UP = -10
local DESTROY_POS_Y_DOWN = 620
local BULLET_RADIUS = 5
local RIGHT_ANGLE = math.rad(90)

local last_time = 0
local last_direction

local random_direction = function()
  local direction = love.math.random(DIRECTION_LOWER, DIRECTION_UPPER)
  
  while (direction == last_direction) do
    direction = love.math.random(DIRECTION_LOWER, DIRECTION_UPPER)
  end
  
  return direction
end

local random_from = function(nums)
  random_i = love.math.random(1, #nums)
  for i = 1, #nums do
    if random_i == i then return nums[i] end
  end
end

local random_proj = function() 
  local direction = random_direction()
  local proj_type = love.math.random(PROJ_LOWER, PROJ_UPPER)
  local velocity = love.math.random(MIN_VELOCITY, MAX_VELOCITY)
  
  if direction == 1 then
    local pos_y = love.math.random(MIN_POS_Y, MAX_POS_Y)
    if proj_type == 1 then
      return arrow(SPAWN_POS_X_LEFT, pos_y, velocity, 0)
    else
      return bullet(SPAWN_POS_X_LEFT, pos_y, BULLET_RADIUS, velocity, 0)
    end
  elseif direction == 2 then
    local pos_y = love.math.random(MIN_POS_Y, MAX_POS_Y)
    if proj_type == 1 then
      return arrow(SPAWN_POS_X_RIGHT, pos_y, -velocity, 0)
    else
      return bullet(SPAWN_POS_X_RIGHT, pos_y, BULLET_RADIUS, -velocity, 0)
    end
  elseif direction == 3 then
    local pos_x = random_from({SPAWN_POS_X_MIDDLE_LEFT, SPAWN_POS_X_MIDDLE_RIGHT})
    if proj_type == 1 then
      local a = arrow(pos_x, SPAWN_POS_Y_DOWN, 0, -velocity)
      a.body:setAngle(RIGHT_ANGLE)
      return a
    else
      return bullet(pos_x, SPAWN_POS_Y_DOWN, BULLET_RADIUS, 0, -velocity)
    end
  else
    local pos_x = random_from({SPAWN_POS_X_MIDDLE_LEFT, SPAWN_POS_X_MIDDLE_RIGHT})
    if proj_type == 1 then
      local a = arrow(pos_x, SPAWN_POS_Y_UP, 0, velocity)
      a.body:setAngle(RIGHT_ANGLE)
      return a
    else
      return bullet(pos_x, SPAWN_POS_Y_UP, BULLET_RADIUS, 0, velocity)
    end
  end
end

return function(entity, index)
  local current_time = love.timer.getTime()
  if current_time - last_time >= SPAWN_INTERVAL then 
    last_time = current_time

    if state.proj_count <= MAX_PROJ then
      table.insert(entities, 1, random_proj())
      state.proj_count = state.proj_count + 1
    end
  end
  
  if entity.type == 'proj' then
    local entity_x = entity.body:getX()
    local entity_y = entity.body:getY()
    
    if entity_x < DESTROY_POS_X_LEFT
    or entity_x > DESTROY_POS_X_RIGHT
    or entity_y < DESTROY_POS_Y_UP
    or entity_y > DESTROY_POS_Y_DOWN
    then
      table.remove(entities, index)
      entity.fixture:destroy()
      state.proj_count = state.proj_count - 1
      state.score = state.score + 1
      sound.effect_score_up()
    end
  end
end
