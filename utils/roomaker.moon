Room = require "../classes/room"

NewRoom = Room!

export *
action  = NewRoom\addAction
inspect = NewRoom\addInspect
use     = NewRoom\addUse
take    = NewRoom\addTake
onEnter = NewRoom\onEnter
endroom = NewRoom