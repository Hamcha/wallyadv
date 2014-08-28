states = require "states"
currentState = states.Title

love.load = ->
    return

love.draw = ->
    currentState.draw!

-- Control scheme
-- Navigation: LEFT  203 | RIGHT     205 | UP 200 | DOWN 208
-- Action    : SPACE  57 | RETURN     28
-- Cancel    : ESC     1 | BACKSPACE  14

love.keypressed = (code) ->
    return