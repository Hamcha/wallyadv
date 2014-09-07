Room = require "../classes/room"

class RoomBuilder
    new: => @room = Room!
    action:      (action, fn) => @room\addAction    action, fn
    locked: (name, item, act) => @room\addLocked    name, item, act
    onEnter:             (fn) => @room\onEnter      fn
    roomend:                  => @room
    subaction:         (name) => (item, action) -> @room\addSubAction name, item, action