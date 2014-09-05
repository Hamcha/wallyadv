GameState = require "../classes/state"
Player    = require "../classes/player"
Input     = require "../utils/input"

Game = GameState!

room = nil

Game.load = =>
    @moveTo "intro"

Game.draw = =>
    room\draw!

Game.update = (dt) =>
    room\update dt

Game.keypressed = (code) =>
    room\keypressed code

Game.moveTo = (roomId) =>
    room = require "../places/" .. roomId
    room\enter!

Game