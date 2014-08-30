class Script
    new: (name) =>
        @lines = {}         -- Lines in the script
        @timepassed  = 0    -- Time passed since last reset (for characters)
        @currentline = 1    -- Current line that's being typewritten
        @inputstate  = 0    -- How many time did we advance?
        @clearpos    = 1    -- Last clear call line
        @pausestart  = 0    -- Last pause call time
        @charspeed   = 20   -- How many character per second
        @maxinput    = 0    -- Where we have come so far
        @pauseamount = 1    -- How much to wait for a pause call
        table.insert @lines, line for line in io.lines "./scripts/" .. name .. ".txt"
    draw: =>
        currentInputState = 0
        currentScreenLine = 0
        for i, line in ipairs @lines
            continue if i < @clearpos -- Too soon? Go ahead!
            break if i > @currentline -- Too far? Go out!

            -- Is a command?
            if (string.sub line, 0, 1) == "."
                -- Command parsing logic here
                command = string.sub line, 2, (string.len line)
                switch command
                    -- .INPUT -- Require user to press ACTION to continue
                    when "INPUT"
                        currentInputState += 1
                        -- Set current inputstate target
                        @maxinput = currentInputState
                        -- Show prompt if needed
                        if @inputstate < currentInputState
                            love.graphics.setColor 8 -- Grey color
                            love.graphics.print "- Press ACTION -", 10, (currentScreenLine + 1) * 10
                            break
                        -- Pressed? Continue!
                        if i == @currentline
                            @nextLine!

                    -- .CLEAR -- Clear the screen
                    when "CLEAR"
                        if i == @currentline
                            @clearpos = i
                            @inputstate = 0
                            @nextLine!
                            break

                    when "PAUSE"
                        if i == @currentline
                            if @timepassed > @pauseamount
                                @nextLine!
                            else
                                break
                    -- Unknown command, throw error
                    else
                        love.graphics.print "Unrecognized command: " .. command, 10, (currentScreenLine + 1) * 10
                continue

            currentScreenLine += 1      -- Advance one line
            love.graphics.setColor 15   -- Set color to white (might change)
            -- Is it the current line? (Typewriter logic)
            if i == @currentline
                subline = string.sub line, 0, @timepassed * @charspeed
                love.graphics.print subline, 10, currentScreenLine * 10
                @nextLine! if @timepassed > (string.len line) / @charspeed
            else
            -- If we already "printed" it just draw it
                love.graphics.print line, 10, currentScreenLine * 10
        -- Debug info, take out when everything works
        love.graphics.setColor 8
        love.graphics.print @currentline .. " " .. @inputstate .. " " .. currentInputState, 0, 0

    update: (dt) =>
        @timepassed += dt

    nextLine: =>
        @timepassed   = 0
        @currentline += 1

    next: =>
        @inputstate += 1 if @inputstate < @maxinput