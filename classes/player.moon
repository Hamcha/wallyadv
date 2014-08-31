class Inventory
    new: => @items = {}

    add:  (name) => @addN name, 1
    addN: (name, qty) =>
        @items[name] = if @items[name] then @items[name] + qty else qty

    removeAll: (name) => @items[name] = nil
    remove:    (name) => @removeN name, 1
    removeN:   (name, qty) =>
        return unless @items[name] ~= nil
        @items[name] -= qty
        @removeAll name unless @items[name] > 0

    has: (name) => @items[name] ~= nil and @items[name] > 0

class Vars
    new: => @vars = {}
    set:  (name, value) => @vars[name] = value
    get:  (name) => @vars[name]
    ison: (name) => @vars[name] == true

class Player
    new: =>
        @inventory = Inventory!
        @vars      = Vars!
    loadGame: =>
        --todo Load savegame
        return
    saveGame: =>
        --todo Write savegame
        return