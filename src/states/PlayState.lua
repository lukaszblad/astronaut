PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.astronaut = Astronaut()
    self.meteorites = {[1] = Meteorite('meteorite5')}

    self.timer = 0
end

function PlayState:update(dt)
    -- update background
    backgroundVelocity = background:update(dt, astronautX)
    
    self.timer = self.timer + dt
    if self.timer > 0.4 then
        randomMeteorite = 'meteorite' .. tostring(math.random(5))
        table.insert(self.meteorites, Meteorite(randomMeteorite))

        -- resetting timer
        self.timer = 0
    end 

    -- updating meteorites
    for index, meteorite in pairs(self.meteorites) do
        meteorite:update(dt, backgroundVelocity)
    end

    -- updating astronaut
    self.astronaut:update(dt)
end

function PlayState:render()
    -- render meteorite
    for index, meteorite in pairs(self.meteorites) do
        meteorite:render()
    end

    -- rendering astronaut
    self.astronaut:render()
end