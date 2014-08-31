class Room
    new: =>
        @actions   = {}
        @inspect   = {}
        @use       = {}
        @take      = {}
        @entered   = nil
    addAction:  (action) => table.insert @actions, action
    addInspect: (action) => table.insert @inspect, action
    addUse:     (action) => table.insert @use,     action
    addTake:    (action) => table.insert @take,    action
    onEnter:    (action) => @entered = action

    draw: =>
        love.graphics.print "in room", 10, 10
        return
    update: (dt) =>
        return
    keypressed: (code) =>
        return