Room = require "../classes/room"

NewRoom = nil

roommaker =
    action:  (action, fn) -> NewRoom\addAction  action, fn
    inspect: (object, fn) -> NewRoom\addInspect object, fn
    use:     (object, fn) -> NewRoom\addUse     object, fn
    take:    (object, fn) -> NewRoom\addTake    object, fn
    onEnter:         (fn) -> NewRoom\onEnter    fn
    roomstart: -> NewRoom = Room!
    roomend:   -> NewRoom

return roommaker