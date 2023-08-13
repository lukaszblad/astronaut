PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.astronaut = Astronaut()
    self.meteorites = Meteorite('meteorite5')

    self.timer = 0
end

function PlayState:update(dt)
    -- self.timer = self.timer + dt
    -- if self.timer > 0.5 then
    --     randomMeteorite = 'meteorite' .. math.random(5) .. 'px'
    --     table.insert(self.meteorites, Meteorite(randomMeteorite))

    --     -- resetting timer
    --     self.timer = 0
    -- end 

    -- updating meteorites
    -- for index, meteorite in pairs(self.meteorites) do
    --     index:update(dt)
    -- end

    self.meteorite:update(dt)

    -- updating astronaut
    self.astronaut:update(dt)

    -- update background
    backgroundVelocity = background:update(dt, astronautX)
end

function PlayState:render()
    -- render meteorite
    -- for index, meteor in pairs(self.meteorites) do
    --     index:render()
    -- end

    self.meteorite:render()

    -- rendering astronaut
    self.astronaut:render()
end