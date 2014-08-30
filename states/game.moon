GameState = require "../classes/state"
Player    = require "../classes/player"
Input     = require "../utils/input"

Game = GameState!

playingCutscene = true
cutscene = nil
finished = false

Game.load = =>
    cutscene = require "../scripts/intro"
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