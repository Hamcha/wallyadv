Cutscene = require "../classes/cutscene"
Input    = require "../utils/input"
CutsceneBuilder = require "../utils/cutmaker"

class Room
    new: =>
        @actions   = {} -- Generic actions ("Look around")
        @inspect   = {} -- Inspect actions ("Inspect <obj>")
        @use       = {} -- Use actions     ("Use <obj>")
        @take      = {} -- Take actions    ("Take <obj>")
        @entered       = nil -- OnEnter cutscene
        @currentaction = nil -- Current cutscene
    addAction:  (name, action) => @actions[name] = @mkaction action
    addInspect: (item, action) => @inspect[item] = @mkaction action
    addUse:     (item, action) => @use[item]     = @mkaction action
    addTake:    (item, action) => @take[item]    = @mkaction action
    onEnter:          (action) => @entered       = @mkaction action

    draw: =>
        -- Draw cutscene if there is an active one
        @currentaction\draw! unless @currentaction == nil
        return

    enter: =>
        -- Set onEnter cutscene as starting cutscene if there is one
        @currentaction = @entered unless @entered == nil

    update: (dt) =>
        -- Update cutscene if there is an active one
        @currentaction\update dt unless @currentaction == nil
        return

    keypressed: (code) =>
        -- Forward to cutscene if there is an active one
        @currentaction\next! if Input.isAction code and @currentaction ~= nil

    mkaction: (action) =>
        cutbuilder = CutsceneBuilder!
        action cutbuilder
        return cutbuilder\cutend!
