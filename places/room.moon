onEnter =>
    line "You are standing in a small hotel"
    line "sized accommodation with one bed."

action "Look Around", =>
    line "The room is worn,"
    line "it looks like you've really budgeted,"
    line "sitting on the desk at the far corner"
    line "of the room you see, [your laptop] and"
    line "an [extra large mayonnaise cup],"
    line "to the right of you, sitting beside a"
    line "curtain covered window is your [bed],"
    line "beside it a [blood stain],"
    line "and [the exit]"

inspect "blood stain", =>
    line "heaping stain of coagulated blood..."
    line "well, it is an all female dormatory."

inspect "bed", =>
    line "small twinsized bunkbed, sometimes"
    line "its nice to catch up on some sleep."

inspect "extra large mayonnaise cup", =>
    line "Your trust extra large mayonaise cup,"
    line "you never leave without it."
    line "The label says it grants you magical"
    line "powers. You should try it."

use "extra large mayonnaise cup", =>
    line "Game Saved"
    line "Uh, that's handy, let's make it more"
    line "obvious"
    Switch\on "canSave"

take "extra large mayonnaise cup", =>
    val = random 3
    if val == 1 then line "An every day part of an healthy diet."
    if val == 2 then line "Can't survive without this."
    if val == 3 then line "How else would my daily life function."
    Inventory\add "mayo"

inspect "your laptop", =>
    line "That keyboard and track pad"
    line "are disgusting..."

use "your laptop", =>
    cutscene "irclog"

use "the exit", =>
    if Inventory\has "mayo"
        line "Well I have everything I need,"
        line "let's go take a look around."
        goto "hallway"
    else
        line "Woah, woah, I'm forgetting something"
        line "pretty damn important..."