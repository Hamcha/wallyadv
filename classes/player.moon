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

class Player
    new: =>
        @inventory = Inventory!
        @switch    = Switch!
    loadGame: =>
        --todo Load savegame
        return
    saveGame: =>
        --todo Write savegame
        return