PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.astronaut = Astronaut()
    self.meteorites = {[1] = Meteorite('meteorite5')}

    self.timer = 0
    self.immunityTimer = 0
end

function PlayState:update(dt)
    -- update background
    backgroundDX, backgroundDY = background:update(dt)
    
    self.timer = self.timer + dt
    if self.timer > 0.2 then
        randomMeteorite = 'meteorite' .. tostring(math.random(5))
        table.insert(self.meteorites, Meteorite(randomMeteorite))

        -- resetting timer
        self.timer = 0
    end 

    -- updating meteorites
    for index, meteorite in pairs(self.meteorites) do
        meteorite:update(dt, backgroundDX, backgroundDY)
        -- check for collision after timeout
        if self.immunityTimer <= 0 then
            -- if astronaut collides reset timeout
            if self.astronaut:collision(meteorite) then
            self.immunityTimer = 2
            end
        end
    end

    -- updating astronaut after hit or after timeout
    if self.immunityTimer == 2 or self.immunityTimer <= 0 then
        self.astronaut:update(dt, self.immunityTimer)
    end

    if self.immunityTimer > 0 then
        self.immunityTimer = self.immunityTimer - dt
    end
    -- remove meteorites
    for index, meteorite in pairs(self.meteorites) do
        if meteorite.remove then
            table.remove(self.meteorites, index)
        end
    end
end

function PlayState:render()
    -- render meteorite
    for index, meteorite in pairs(self.meteorites) do
        meteorite:render()
    end

    for i = 0, self.astronaut.health - 1 do
        love.graphics.draw(gSprites['bar'], (i * 10) + 5, 10)
    end

    -- rendering astronaut
    self.astronaut:render()
end
