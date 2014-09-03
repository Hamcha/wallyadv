Cutscene = require "../classes/cutscene"
Input    = require "../utils/input"
CutsceneBuilder = require "../utils/cutmaker"

class Room
    new: =>
        @actions   = {} -- Generic actions ("Look around")
        @inspect   = {} -- Inspect actions ("Inspect <obj>")
        @use       = {} -- Use actions     ("Use <obj>")
        @take      = {} -- Take actions    ("Take <obj>")
        @locked    = {} -- Locked actions
        @entered         = nil   -- OnEnter cutscene
        @currentaction   = nil   -- Current cutscene
        @playingCutscene = false -- Are we playing a cutscene?
        @selectedOption  = 1     -- Which option is selected on the menu
        @maxOptionNum    = 1     -- Maximum option for input checks
        @optionStatus    = 0     -- Menu status (Generic, item etc)
    addAction:  (name, action) => @actions[string.upper name] = @mkaction action, true
    addInspect: (item, action) => @inspect[string.upper item] = @mkaction action, true
    addUse:     (item, action) => @use[string.upper item]     = @mkaction action, true
    addTake:    (item, action) => @take[string.upper item]    = @mkaction action, true
    onEnter:          (action) => @entered                    = @mkaction action, false

    addLocked:  (action) =>
        table.insert @locked, action
        return #@locked

    draw: =>
        -- Draw cutscene if there is an active one
        @currentaction\draw! unless @currentaction == nil
        return if @playingCutscene

        -- Draw menu
        printline = @currentaction.currentScreenLine + 2
        len = 0
        tlen = 0
        for i, action in ipairs @getGenericActions!
            love.graphics.setColor 15
            if @selectedOption == i
                love.graphics.rectangle "fill", 10 + 8 * len, 10 * printline - 2, (string.len action) * 8, 11
                love.graphics.setColor 0
            love.graphics.print action, 10 + 8 * len, 10 * printline
            len += (string.len action) + 1
            tlen += 1
        @maxOptionNum = tlen

    enter: =>
        -- Set onEnter cutscene as starting cutscene if there is one
        @currentaction = @entered unless @entered == nil
        @playingCutscene = true
        @currentaction\atEnd (cut) ->
            @playingCutscene = false

    update: (dt) =>
        -- Update cutscene if there is an active one
        @currentaction\update dt unless @currentaction == nil

    keypressed: (code) =>
        -- Forward to cutscene if there is an active one
        if @playingCutscene
            @currentaction\next! if Input.isAction code and @currentaction ~= nil
            return

        @selectedOption -= 1 if code == Input.Left and @selectedOption > 1
        @selectedOption += 1 if code == Input.Right and @selectedOption < @maxOptionNum

        if Input.isAction code
            return

    mkaction: (action, clear) =>
        cutbuilder = CutsceneBuilder!
        cutbuilder\setParent self
        action cutbuilder
        if clear
            cutbuilder\input!
            cutbuilder\clear!
        return cutbuilder\cutend!

    getGenericActions: =>
        list = {}
        -- Get all actions
        for k,v in pairs @actions
            table.insert list, k
        -- Check for possible INSPECT/USE/TAKE actions
        for k,v in pairs @inspect
            table.insert list, "INSPECT"
            break
        for k,v in pairs @use
            table.insert list, "USE"
            break
        for k,v in pairs @take
            table.insert list, "TAKE"
            break
        return list

    unlock: (i) => @locked[i]!