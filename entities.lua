-- entities.lua

local game_over_text = require('entities/text/game-over')
local pause_text = require('entities/text/pause')
local score_text = require('entities/text/score')
local player = require('entities/player')

local entities = {
  player(),
  game_over_text(),
  pause_text(),
  score_text()
}

return entities
