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

Game