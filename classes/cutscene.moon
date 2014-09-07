class Cutscene
    new: () =>
        @lines = {}         -- Lines in the script
        @timepassed  = 0    -- Time passed since last reset (for characters)
        @currentline = 1    -- Current line that's being typewritten
        @inputstate  = 0    -- How many time did we advance?
        @clearpos    = 1    -- Last clear call line
        @pausestart  = 0    -- Last pause call time
        @charspeed   = 25   -- How many character per second
        @maxinput    = 0    -- Where we have come so far
        @finished    = nil  -- On Cutscene Ended callback
        @color       = 15   -- Text color
        @offset      = 0    -- Offset for sameline calls
        @lastlinelength = 0 -- Used for sameline calls

    addLine:     (text) => table.insert @lines, (i) -> @line     i, text
    addSameline: (text) => table.insert @lines, (i) -> @sameline i, text
    addCall:       (fn) => table.insert @lines, (i) -> @call     i, fn
    addPause:  (amount) => table.insert @lines, (i) -> @pause    i, amount
    addSpeed:  (amount) => table.insert @lines, (i) -> @setspeed i, amount
    addClear:  => table.insert @lines, (i) -> @clear i
    addInput:  => table.insert @lines, (i) -> @input i
    addEnd:    => table.insert @lines, (i) -> @cutend!
    addUnlock: (room, idx) => table.insert @lines, (i) -> @unlock i, room, idx
    addMove: (game, room) => table.insert @lines, (i) -> @moveto i, game, room

    draw: =>
        --todo Consider switching to a function-based approach
        @currentInputState = 0
        @currentScreenLine = 0
        for i, line in ipairs @lines
            continue if i < @clearpos -- Too soon? Go ahead!
            break if i > @currentline -- Too far?  Go out!
            cancontinue = line i
            break unless cancontinue

    update: (dt) =>
        @timepassed += dt

    nextLine: =>
        @timepassed   = 0
        @currentline += 1

    next: =>
        @inputstate += 1 if @inputstate < @maxinput

    atEnd: (cb) => @finished = cb

    -- Commands

    input: (i) =>
        @currentInputState += 1
        -- Set current inputstate target
        @maxinput = @currentInputState
        -- Show prompt if needed
        if @inputstate < @currentInputState
            love.graphics.setColor 8 -- Grey color
            love.graphics.print "- Press ACTION -", 10, (@currentScreenLine + 1) * 10
            return false
        -- Pressed? Continue!
        if i == @currentline
            @nextLine!
        return true

    pause: (i, amount) =>
        if i == @currentline
            if @timepassed > amount
                @nextLine!
            else
                return false
        return true

    clear: (i) =>
        if i == @currentline
            @clearpos = i
            @inputstate = 0
            @nextLine!
            return false
        return true

    cutend: =>
        @finished! unless @finished == nil
        return false

    line: (i, line) =>
        line = "" if line == nil
        love.graphics.setColor @color   -- Set text color
        @currentScreenLine += 1         -- Advance one line
        -- Is it the current line? (Typewriter logic)
        if i == @currentline
            subline = string.sub line, 0, @timepassed * @charspeed
            love.graphics.print subline, (@offset + 1) * 8, @currentScreenLine * 10
            @nextLine! if (string.len subline) >= (string.len line)
            @lastlinelength = @offset + string.len subline
            return false
        else
        -- If we already "printed" it just draw it
            love.graphics.print line, (@offset + 1) * 8, @currentScreenLine * 10
            @lastlinelength = @offset + string.len line
        return true

    sameline: (i, line) =>
        @currentScreenLine -= 1
        @offset = @lastlinelength
        ret = @line i, line
        @offset = 0
        return ret

    setspeed: (i, amount) =>
        if i == @currentline
            @charspeed = amount
            @nextLine!
        return true

    call: (i, fn) =>
        if i == @currentline
            return fn!
        return true

    unlock: (i, room, idx) =>
        if i == @currentline
            room\unlock idx
            @nextLine!
        return true

    moveto: (i, game, room) =>
        if i == @currentline
            game\moveTo room
        return true