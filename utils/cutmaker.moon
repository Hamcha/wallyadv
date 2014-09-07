Cutscene = require "../classes/cutscene"

class CutsceneBuilder
    new: =>
        @cutscene = Cutscene!
        @parent   = nil
    setParent: (obj) => @parent = obj
    clear:           => @cutscene\addClear!
    input:           => @cutscene\addInput!
    call:            => @cutscene\addCall!
    line:      (txt) => @cutscene\addLine     txt
    pause:     (amt) => @cutscene\addPause    amt
    setspeed:  (amt) => @cutscene\addSpeed    amt
    sameline:  (txt) => @cutscene\addSameline txt
    color:     (idx) => @cutscene\addColor    idx
    unlock:      (i) => @cutscene\addUnlock @parent, i
    moveto:    (loc) => @cutscene\addMove   states.current, loc
    cutend: =>
        @cutscene\addEnd!
        return @cutscene