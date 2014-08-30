GameState = require "../classes/state"
Player    = require "../classes/player"
Input     = require "../utils/input"
Cutscene  = require "../classes/cutscene"

Game = GameState!

playingCutscene = true
cutscene = nil
finished = false

Game.load = =>
    cutscene = Cutscene "intro"
    cutscene\atEnd => playingCutscene = false

Game.draw = =>
    -- Playing cutscene? Just forward events
    return cutscene\draw! if playingCutscene

Game.update = (dt) =>
    -- Playing cutscene? Just forward events
    return cutscene\update dt if playingCutscene

Game.keypressed = (code) =>
    -- Playing cutscene? Just forward events
    return cutscene\next! if playingCutscene and Input.isAction code

Game