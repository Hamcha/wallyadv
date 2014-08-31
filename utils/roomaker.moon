Room = require "../classes/room"

NewRoom = nil

roommaker =
    action:  NewRoom\addAction
    inspect: NewRoom\addInspect
    use:     NewRoom\addUse
    take:    NewRoom\addTake
    onEnter: NewRoom\onEnter
    roomstart: -> NewRoom = Room!
    roomend:   -> NewRoom

return roommaker