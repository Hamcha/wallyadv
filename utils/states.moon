class States
    -- Game states
    Title: require "./states/title"
    Game:  require "./states/game"

    -- Current state
    current: nil

    -- State-changing methods
    switchTo: (newState) =>
        @current.unload!
        @current = newState
        @current.load!

States!