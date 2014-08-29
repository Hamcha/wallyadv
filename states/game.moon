GameState = require "../classes/state"
Player = require "../classes/player"

Game = GameState!

Game.draw = ->
    love.graphics.print "INGAME!", 10, 10

Game