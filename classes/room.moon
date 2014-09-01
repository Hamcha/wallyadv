import
    line
    sameline
    input
    clear
    pause
    cutstart
    cutend
    call
    from require "../utils/cutmaker"

class Room
    new: =>
        @actions   = {}
        @inspect   = {}
        @use       = {}
        @take      = {}
        @entered   = nil
    addAction:  (name, action) => @actions[name] = @mkaction action
    addInspect: (item, action) => @inspect[item] = @mkaction action
    addUse:     (item, action) => @use[item]     = @mkaction action
    addTake:    (item, action) => @take[item]    = @mkaction action
    onEnter:          (action) => @entered       = @mkaction action

    draw: =>
        love.graphics.print "in room", 10, 10
        return
    update: (dt) =>
        return
    keypressed: (code) =>
        return
    mkaction: (action) =>
        cutstart!
        action!
        cutend!