class States
    -- Game states
    Title: require "states/title"
    Game: require "states/game"

    -- Current state
    current: nil

    -- State-changing methods
    switchTo: (newState) =>
        @current.unload!
        @current = require "states/" .. newState
        @current.load!

States!