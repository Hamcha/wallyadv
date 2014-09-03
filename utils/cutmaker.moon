Cutscene = require "../classes/cutscene"

class CutsceneBuilder
    new: =>
        @cutscene = Cutscene!
        @parent   = nil
    setParent: (obj) => @parent = obj
    clear:           => @cutscene\addClear!
    input:           => @cutscene\addInput!
    line:      (txt) => @cutscene\addLine txt
    pause:     (amt) => @cutscene\addPause amt
    setspeed:  (amt) => @cutscene\addSpeed!
    sameline:  (txt) => @cutscene\addSameline!
    call:            => @cutscene\addCall!
    unlock:      (i) => @cutscene\addUnlock @parent, i
    cutend: =>
        @cutscene\addEnd!
        return @cutscene
    moveto: => return