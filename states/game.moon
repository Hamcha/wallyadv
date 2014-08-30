GameState = require "../classes/state"
Player    = require "../classes/player"
Input     = require "../utils/input"
Cutscene  = require "../classes/cutscene"

Game = GameState!

cutscene = nil
finished = false

Game.load = =>
    cutscene = Cutscene "intro"
    cutscene\atEnd => finished = true

Game.draw = =>
    if finished
        love.graphics.print "FINISHED", 10, 10
    else
        cutscene\draw!

Game.update = (dt) =>
    cutscene\update dt

Game.keypressed = (code) =>
    cutscene\next! if Input.isAction code

Game