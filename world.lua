-- world.lua

local begin_contact_callback = function(fixture_a, fixture_b, contact)
  local entity_a = fixture_a:getUserData()
  local entity_b = fixture_b:getUserData()
  if entity_a.begin_contact then entity_a:begin_contact() end
  if entity_b.begin_contact then entity_b:begin_contact() end
end

local end_contact_callback = function(fixture_a, fixture_b, contact)
  local entity_a = fixture_a:getUserData()
  local entity_b = fixture_b:getUserData()
  if entity_a.end_contact then entity_a:end_contact() end
  if entity_b.end_contact then entity_b:end_contact() end
end

local world = love.physics.newWorld(0, 0)

world:setCallbacks(begin_contact_callback, end_contact_callback, nil, nil)

return world
