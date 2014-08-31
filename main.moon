export states = require "./utils/states"
export player = (require "./classes/player")!

love.load = ->
    states.current = states.Game
    states.current\load!

love.update = (dt) ->
    states.current\update dt

love.draw = ->
    states.current\draw!

love.keypressed = (code) ->
    states.current\keypressed code