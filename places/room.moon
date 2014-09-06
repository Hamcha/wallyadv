import
    \roomend
    \onEnter
    \action
    \inspect
    \subaction
    \locked
    from (require "../utils/roomaker")!

inspect = subaction "inspect"
use     = subaction "use"
take    = subaction "take"

onEnter =>
    @line "You are standing in a small hotel"
    @line "sized accommodation with one bed."

iblood = locked => inspect "blood stain", =>
    @line "Heaping stain of coagulated blood..."
    @line "well, it is an all female dormatory."

ibed = locked => inspect "bed", =>
    @line "Small twinsized bunkbed, sometimes"
    @line "its nice to catch up on some sleep."

usemayo = locked => use "extra large mayonnaise cup", =>
    @line "Game Saved"
    player.vars\set "canSave", true
    --todo Save!

takemayo = locked => take "extra large mayonnaise cup", =>
    val = math.random 3
    if val == 1 then @line "An every day part of an healthy diet."
    if val == 2 then @line "Can't survive without this."
    if val == 3 then @line "How else would my daily life function."
    player.inventory\add "mayo"

imayo = locked => inspect "extra large mayonnaise cup", =>
    @line "Your trusty extra large mayonaise cup,"
    @line "you never leave without it."
    @line "The label says it grants you magical"
    @line "powers. You should try it."
    @unlock usemayo
    @unlock takemayo

ulap = locked => use "your laptop", =>
    @line "An old IRC log is left open on your "
    @line "laptop from the other night"
    @input!
    @clear!
    @line "<jnerula> Nevermind its too goddamn"
    @line " hot, I guess I'll venture forth into"
    @line " the unknown"
    @line "<jnerula> Find some water and a"
    @line " fucking towel"
    @line "<dx> jnerula: take pics"
    @line "<dx> jnerula: and selfies"
    @line "<dx> jnerula: and shoe on head"
    @line "<dx> jnerula: and sharpie in pooper"
    @line "<jnerula> You cant tell me what to do"
    @line "<dx> jnerula: i am your father"
    @line "<jnerula> I'll take one picture that"
    @line " is all of those things"
    @line "<dx> ok"
    @line "<Hamcha> noted"
    @line "<Hamcha> now go do it"
    @input!
    @clear!
    @line "Oh! So that was what I needed to do!"

ilap = locked => inspect "your laptop", =>
    @line "That keyboard and track pad"
    @line "are disgusting..."

uexit = locked => use "the exit", =>
    if player.inventory\has "mayo"
        @line "Well I have everything I need,"
        @line "let's go take a look around."
        @input!
        @clear!
        @moveto "hallway"
    else
        @line "Woah, woah, I'm forgetting something"
        @line "pretty damn important..."

action "Look Around", =>
    @line "The room is worn,"
    @line "it looks like you've really budgeted,"
    @line "sitting on the desk at the far corner"
    @line "of the room you see, your laptop and"
    @line "an extra large mayonnaise cup, to the"
    @line "right of you, sitting beside a"
    @line "curtain covered window is your bed,"
    @line "beside it a blood stain, and the exit"
    @unlock iblood
    @unlock ibed
    @unlock ilap
    @unlock ulap
    @unlock imayo
    @unlock uexit

roomend!