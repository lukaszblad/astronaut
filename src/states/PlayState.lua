PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.astronaut = Astronaut()
    self.meteorite = Meteorite('meteorite5')

    self.timer = 0
end

function PlayState:update(dt)
    -- updating astronaut
    self.astronaut:update(dt)

    -- update background
    backgroundVelocity = background:update(dt, astronautX)

    self.meteorite:update(dt, backgroundVelocity)
end

function PlayState:render()
    -- rendering astronaut
    self.astronaut:render()

    --render meteorite
    self.meteorite:render()
end