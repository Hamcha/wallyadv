Cutscene = require "../classes/cutscene"
Input    = require "../utils/input"
CutsceneBuilder = require "../utils/cutmaker"

class Room
    new: =>
        @actions         = {}    -- Generic actions ("Look around")
        @subactions      = {}    -- Subactions ("Inspect / Talk / Touch")
        @locked          = {}    -- Locked actions
        @entered         = nil   -- OnEnter cutscene
        @currentaction   = nil   -- Current cutscene
        @playingCutscene = false -- Are we playing a cutscene?
        @selectedOption  = 1     -- Which option is selected on the menu
        @selectedItem    = 1     -- Which item is selected on the submenu
        @maxOptionNum    = 1     -- Maximum option for input checks
        @maxItemNum      = 1     -- Maximum item for input checks
        @currentMenu     = nil   -- Menu status (Generic, item etc)
    onEnter:      (action) => @entered = -> @mkaction action
    addAction:    (name, action) => @actions[string.upper name] = -> @mkaction action
    addSubAction: (name, item, action) =>
        uppname = string.upper name
        @subactions[uppname] = {} unless @subactions[uppname] ~= nil
        @subactions[uppname][item] = -> @mkaction action

    addLocked:  (name, item, action) =>
        table.insert @locked, -> name item, action
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
            -- Set color to white
            love.graphics.setColor 15
            if (@currentMenu == nil and @selectedOption == i) or @currentMenu == action
                -- Selection box
                love.graphics.rectangle "fill", 8 * (len + 1), 10 * printline - 2, (string.len action) * 8, 11
                love.graphics.setColor 0
            love.graphics.print action, 8 * (len + 1), 10 * printline
            len += (string.len action) + 1
            tlen += 1
        @maxOptionNum = tlen
        return unless @currentMenu ~= nil
        tlen = 0
        printline += 1
        for i, item in ipairs @getSpecificActions @currentMenu
            -- Set color to white
            love.graphics.setColor 15
            if @selectedItem == i
                -- Selection arrow
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
            @currentaction\next! if Input.isAction code
            return

        -- Menu movement (left/right for actions / up/down for subactions)
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
                cutscene = @subactions[@currentMenu][item]
                @play cutscene
                @selectedItem = 1
                @currentMenu = nil
            -- Generic menu
            else
                actions = @getGenericActions!
                @currentMenu = actions[@selectedOption]
                @selectedItem = 1
                -- If it's an action play it immediately
                if @subactions[@currentMenu] == nil
                    @play @actions[@currentMenu]
                    @selectedOption = 1
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
        -- Check for possible subactions
        for k,v in pairs @subactions
            table.insert list, k
        -- Get all other actions
        for k,v in pairs @actions
            table.insert list, k
        return list

    getSpecificActions: (name) =>
        list = {}
        table.insert list, k for k,v in pairs @subactions[name]
        return list

    play: (cutscene) =>
        @currentaction = cutscene!
        @playingCutscene = true
        @currentaction\atEnd (cut) ->
            @playingCutscene = false

    unlock: (i) => @locked[i]!