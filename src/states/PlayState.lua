PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.astronaut = Astronaut()
    self.meteorites = {[1] = Meteorite('meteorite5')}

    self.timer = 0
    self.count = 0
end

function PlayState:update(dt)
    -- update background
    backgroundDX, backgroundDY = background:update(dt)
    
    self.timer = self.timer + dt
    if self.timer > 0.5 then
        randomMeteorite = 'meteorite' .. tostring(math.random(5))
        table.insert(self.meteorites, Meteorite(randomMeteorite))

        -- resetting timer
        self.timer = 0
        self.count = self.count + 1
    end 

    -- updating meteorites
    for index, meteorite in pairs(self.meteorites) do
        meteorite:update(dt, backgroundDX, backgroundDY)
    end

    -- updating astronaut
    self.astronaut:update(dt)

    -- remove meteorites
    for index, meteorite in pairs(self.meteorites) do
        if meteorite.remove then
            table.remove(self.meteorites, index)

            self.count = self.count - 1
        end
    end
end

function PlayState:render()
    -- render meteorite
    for index, meteorite in pairs(self.meteorites) do
        meteorite:render()
    end

    -- rendering astronaut
    self.astronaut:render()
end