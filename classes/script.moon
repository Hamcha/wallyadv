class Script
    new: (name) =>
        @lines = {}
        table.insert @lines, line for line in io.lines "./scripts/" .. name .. ".txt"
    draw: =>
        for i, line in ipairs @lines
            love.graphics.print line, 10, i * 10