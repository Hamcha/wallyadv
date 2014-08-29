export states = require "./utils/states"

love.load = ->
    states.current = states.Title
    states.current\load!

love.update = (dt) ->
    states.current\update dt

love.draw = ->
    states.current\draw!

love.keypressed = (code) ->
    states.current\keypressed code