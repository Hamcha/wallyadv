class Script
    new: (name) =>
        @lines = {}
        @timepassed = 0
        @inputstate = 0
        table.insert @lines, line for line in io.lines "./scripts/" .. name .. ".txt"
    draw: =>
        for i, line in ipairs @lines
            if (string.sub line, 0, 1) == "."
                return
            love.graphics.print line, 10, i * 10
    update: (dt) =>
        @timepassed = @timepassed + dt