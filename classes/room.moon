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
        @selectedItem    = 1     -- Which item is selected on the submenu
        @maxOptionNum    = 1     -- Maximum option for input checks
        @maxItemNum      = 1     -- Maximum item for input checks
        @currentMenu     = nil   -- Menu status (Generic, item etc)
    addAction:  (name, action) => @actions[string.upper name] = -> @mkaction action
    addInspect: (item, action) => @inspect[item]              = -> @mkaction action
    addUse:     (item, action) => @use[item]                  = -> @mkaction action
    addTake:    (item, action) => @take[item]                 = -> @mkaction action
    onEnter:          (action) => @entered                    = -> @mkaction action

    addLocked:  (builder, action) =>
        table.insert @locked, => action builder
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
            if (@currentMenu == nil and @selectedOption == i) or @currentMenu == action
                love.graphics.rectangle "fill", 8 + 8 * len, 10 * printline - 2, (string.len action) * 8, 11
                love.graphics.setColor 0
            love.graphics.print action, 8 + 8 * len, 10 * printline
            len += (string.len action) + 1
            tlen += 1
        @maxOptionNum = tlen
        return unless @currentMenu ~= nil
        tlen = 0
        printline += 1
        for i, item in ipairs @getSpecificActions @currentMenu
            love.graphics.setColor 15
            if @selectedItem == i
                love.graphics.print ">", 8, 10 * printline
            love.graphics.print item, 16, 10 * printline
            printline += 1
            tlen += 1
        @maxItemNum = tlen

    enter: =>
        -- Set onEnter cutscene as starting cutscene if there is one
        @play @entered unless @entered == nil

    update: (dt) =>
        -- Update cutscene if there is an active one
        @currentaction\update dt unless @currentaction == nil

    keypressed: (code) =>
        -- Forward to cutscene if there is an active one
        if @playingCutscene
            @currentaction\next! if Input.isAction code and @currentaction ~= nil
            return

        if @currentMenu == nil
            @selectedOption -= 1 if code == Input.Left and @selectedOption > 1
            @selectedOption += 1 if code == Input.Right and @selectedOption < @maxOptionNum
        else
            @selectedItem -= 1 if code == Input.Up and @selectedItem > 1
            @selectedItem += 1 if code == Input.Down and @selectedItem < @maxItemNum


        if Input.isAction code
            -- Specific menu
            if @currentMenu ~= nil
                item = (@getSpecificActions @currentMenu)[@selectedItem]
                cutscene = @getSpecificCutscene @currentMenu, item
                @play cutscene
                @currentMenu = nil
            -- Generic menu
            else
                actions = @getGenericActions!
                @currentMenu = actions[@selectedOption]
                @selectedItem = 1
                if @currentMenu ~= "INSPECT" and @currentMenu ~= "USE" and @currentMenu ~= "TAKE"
                    @play @actions[@currentMenu]
                    @currentMenu = nil
        if Input.isCancel code
            -- Specific menu (goto generic)
            if @currentMenu ~= nil
                @currentMenu = nil

    mkaction: (action) =>
        cutbuilder = CutsceneBuilder!
        cutbuilder\setParent self
        action cutbuilder
        return cutbuilder\cutend!

    getGenericActions: =>
        list = {}
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
        -- Get all other actions
        for k,v in pairs @actions
            table.insert list, k
        return list

    getSpecificActions: (name) =>
        list = {}
        switch name
            when "INSPECT" then table.insert list, k for k,v in pairs @inspect
            when "USE"     then table.insert list, k for k,v in pairs @use
            when "TAKE"    then table.insert list, k for k,v in pairs @take
        return list

    getSpecificCutscene: (action, item) =>
        switch action
            when "INSPECT" then @inspect[item]
            when "USE"     then @use[item]
            when "TAKE"    then @take[item]

    play: (cutscene) =>
        @currentaction = cutscene!
        @playingCutscene = true
        @currentaction\atEnd (cut) ->
            @playingCutscene = false

    unlock: (i) => @locked[i]!