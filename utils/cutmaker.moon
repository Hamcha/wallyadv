Cutscene = require "../classes/cutscene"

NewCutscene = Cutscene!

export *
line  = NewCutscene\addLine
pause = NewCutscene\addPause
clear = NewCutscene\addClear
input = NewCutscene\addInput
setspeed = NewCutscene\addSpeed
sameline = NewCutscene\addSameline
cutend = =>
    NewCutscene\addEnd!
    return NewCutscene