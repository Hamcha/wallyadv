GameState = require "../classes/state"
Player    = require "../classes/player"
Input     = require "../utils/input"
Script    = require "../classes/script"

Game = GameState!

currentScript = nil

Game.load = =>
    currentScript = Script "intro"

Game.draw = =>
    currentScript\draw!

Game.update = (dt) =>
    currentScript\update dt

Game.keypressed = (code) =>
    currentScript\next! if Input.isAction code

Game