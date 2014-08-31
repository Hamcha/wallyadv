class Inventory
    new: => @items = {}
    add: (name) =>
        if @items[name]
            @items[name] += 1
        else
            @items[name] = 1

class Switch
    new: =>
        @switches = {}
    set:  (name, value) => @switches[name] = value
    get:  (name) => @switches[name]
    ison: (name) => @switches[name] == true

class Room
    new: =>
        @inventory = Inventory!
        @switch    = Switch!
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