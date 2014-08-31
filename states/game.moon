GameState = require "../classes/state"
Player    = require "../classes/player"
Input     = require "../utils/input"

Game = GameState!

playingCutscene = true
cutscene = nil
room = nil
finished = false

Game.load = =>
    room = require "../places/room"
    --cutscene = require "../scripts/intro"
    --cutscene\atEnd =>
    --    room = require "../places/room"
    playingCutscene = false

Game.draw = =>
    -- Playing cutscene? Just forward events
    if playingCutscene
        cutscene\draw!
    else
        room\draw!

Game.update = (dt) =>
    -- Playing cutscene? Just forward events
    if playingCutscene
        cutscene\update dt
    else
        room\update dt

Game.keypressed = (code) =>
    -- Playing cutscene? Just forward events
    if playingCutscene
        cutscene\next! if Input.isAction code
    else
        room\keypressed code

Game