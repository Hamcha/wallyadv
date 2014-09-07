import
    \roomend
    \onEnter
    \action
    \subaction
    \locked
    from (require "../utils/roomaker")!

inspect = subaction "inspect"
use     = subaction "use"

ustairway = locked use,"stairway", =>
    @line "You take the stairwell down to"
    @line "the lobby."
    @input!
    @clear!
    @moveto "lobby"

istarway = locked inspect, "stairway", =>
    @line "The stairway leads to the lobby of"
    @line "the dormitory."
    @unlock ustairway

uelevator = locked use, "elevator", =>
    @line "You press the button and the elevator"
    @line "makes its way to the second floor and"
    @line "opens, inside is an old lady."
    @pause .5
    @line!
    @line "You enter the elevator and it starts"
    @line "moving down..."
    @input!
    @clear!
    @moveto "elevator"

ielevator = locked inspect, "elevator", =>
    @line "It seems slow, but it also leads"
    @line "to the lobby."
    @unlock uelevator

ulaundry = locked use, "laundry hole", =>
    @moveto "city"

ilaundry = locked inspect, "laundry hole", =>
    @line "This likely leads to the laundry room,"
    @line "could be a fun way down to the lobby."
    @unlock ulaundry

onEnter =>
    @line "You've entered the dormitory halls."
    @pause 0.5
    @line "The hallway is unclean, the light"
    @line "fixtures are flickering, and there"
    @line "aside from the industrial ambience of"
    @line "the city outside, it seems to be"
    @line "extremely quiet."
    @line!
    @pause 0.5
    @line "\"Smells like... cheap perfume.."
    @pause 0.5
    @line " my nostrils are burning, I guess"
    @line " that's just the singe of that fresh,"
    @line " clean, Chinese air.\" you think."
    @line!
    @pause 0.5
    @line "You feel blood drip from your nose to"
    @line "the floor..."

action "Look Around", =>
    @line "Looking around you see a stairway,"
    @line "an elevator, a laundry chute,"
    @line "the door to your room, while the rest"
    @line "of the rooms seem to be sealed... with"
    @line "bricks."
    @unlock istarway
    @unlock ielevator
    @unlock ilaundry

roomend!