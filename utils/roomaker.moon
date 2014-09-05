Room = require "../classes/room"

class RoomBuilder
    new: => @room = Room!
    action:  (action, fn) => @room\addAction  action, fn
    inspect: (object, fn) => @room\addInspect object, fn
    use:     (object, fn) => @room\addUse     object, fn
    take:    (object, fn) => @room\addTake    object, fn
    locked:  (fn)         => @room\addLocked  self, fn
    onEnter:         (fn) => @room\onEnter    fn
    roomend:              => @room