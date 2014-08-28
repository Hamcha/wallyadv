states = require "states"
currentState = states.Title

love.load = ->
    return

love.update = (dt) ->
    currentState.update dt

love.draw = ->
    currentState.draw!

love.keypressed = (code) ->
    currentState.keypressed code