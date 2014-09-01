Cutscene = require "../classes/cutscene"

NewCutscene = nil

cutmaker =
    clear:          -> NewCutscene\addClear!
    input:          -> NewCutscene\addInput!
    line:     (txt) -> NewCutscene\addLine txt
    pause:    (amt) -> NewCutscene\addPause amt
    setspeed: (amt) -> NewCutscene\addSpeed!
    sameline: (txt) -> NewCutscene\addSameline!
    call:           -> NewCutscene\addCall!
    cutstart:       -> NewCutscene = Cutscene!
    cutend: ->
        NewCutscene\addEnd!
        return NewCutscene

return cutmaker