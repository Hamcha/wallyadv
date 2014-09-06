Room = require "../classes/room"

class RoomBuilder
    new: => @room = Room!
    action:    (action, fn) => @room\addAction    action, fn
    locked:            (fn) => @room\addLocked    self, fn
    subaction:       (name) => @room\addSubAction name
    onEnter:           (fn) => @room\onEnter      fn
    roomend:                => @room