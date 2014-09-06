import
    \roomend
    \onEnter
    \action
    \locked
    \subaction
    from (require "../utils/roomaker")!

inspect = subaction "inspect"
touch   = subaction "touch"

onEnter =>
    @line "You walk casually down the stairwell"
    @line "and into the dormitory's lobby."

inspect "frightened woman", =>
    @line "As you glare at the frightened woman"
    @line "and look over her, she glares back"
    @line "at you seeming more frightened she's"
    @line "obviously an older woman, a lot of"
    @line "wrinkles, you're fucking weirding"
    @line "her out with the stairing man..."
    @pause 0.5
    @line!
    @line "Maybe she has a towel.."

action "Look Around", =>
    @line "You see, a frightened woman standing"
    @line "behind the front desk, the building"
    @line "exit, an elevator and the stairwell"

touch "frightened woman", =>
    @line "She's shouting at you!"
    @pause 0.5
    @line!
    @line "\"You no fuck old asian lady pervy"
    @line "white man!\""

roomend!