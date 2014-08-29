GameState = require "../classes/state"
Input = require "../utils/input"

-- NEW GAME (0) - CONTINUE (1) - EXIT (2)
option = 0

Title = GameState!
Title.draw = =>
    -- Header and footer
    love.graphics.print "Wally's Grand Adventure", 10, 10
    love.graphics.print "Olegfilm Games", 205, 190

    -- Option text
    love.graphics.print "Discover Taiwan (New save)", 20, 30
    love.graphics.print "Continue from last time", 20, 40
    love.graphics.print "Go home", 20, 50

    -- Option cursor
    love.graphics.print ">", 10, 30+option*10

Title.keypressed = (code) =>
    option = option - 1 if code == Input.Up and option > 0
    option = option + 1 if code == Input.Down and option < 2
    if Input.isAction code
        switch option
            when 0 -- New Game
                states\switchTo states.Game
            when 1 -- Load
                --todo
                return
            when 2 -- Exit
                os.exit!

Title