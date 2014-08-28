lastcode = 0

love.draw = ->
    love.graphics.print "WALLY.EXE TEST", 20, 20
    love.graphics.print "Code: " .. lastcode, 30, 30

love.keypressed = (code) ->
    os.exit! if code == 1 -- Exit on ESC (temporary)
    lastcode = code