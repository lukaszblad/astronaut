PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.astronaut = Astronaut()
    self.meteorites = {[1] = Meteorite('meteorite5')}
    self.powerups = {[1] = PowerUp('o2Refill.png')}

    self.meteoriteTimer = 0
    self.immunityTimer = 0
    self.o2Timer = 0

    self.o2 = 49
end

function PlayState:update(dt)
    -- update background
        background:scrollX(dt)
        background:scrollY(dt)
    
    -- spawn new meteorites
    self.meteoriteTimer = self.meteoriteTimer + dt
    if self.meteoriteTimer > 0.1 then
        randomMeteorite = 'meteorite' .. tostring(math.random(5))
        table.insert(self.meteorites, Meteorite(randomMeteorite))

        -- reducing o2 level
        self.o2 = self.o2 - 0.1

        -- resetting timer
        self.meteoriteTimer = 0
    end

    -- spawn powerups
    self.o2Timer = self.o2Timer + dt
    if self.o2Timer > 1 then
        table.insert(self.powerups, PowerUp())
        self.o2Timer = 0
    end

    -- update meteorites
    for index, meteorite in pairs(self.meteorites) do
        meteorite:update(dt, background.dx, background.dy)
        -- check for collision after timeout
        if self.immunityTimer <= 0 then
            -- if astronaut collides reset timeout
            if self.astronaut:collideMeteorite(meteorite) then
                self.immunityTimer = 2
                gSounds['damage']:play()
                background.dx = - background.dx / 4
                background.dy = - background.dy / 4
            end
        end
    end

    -- update powerups
    for index, powerup in pairs(self.powerups) do
        powerup:update(dt, background.dx, background.dy)
        -- detect collision
        if self.astronaut:collidePowerUp(powerup) then
            if self.o2 >= 39 then
                self.o2 = 49
            else
                self.o2 = self.o2 + 10
            end
            gSounds['powerup']:play()
            table.remove(self.powerups, index)
        end
    end

    -- updating astronaut after hit or after timeout
    if self.immunityTimer == 2 or self.immunityTimer <= 0 then
        self.astronaut:update(dt, self.immunityTimer)
    end

    -- immunity timer decrese
    if self.immunityTimer > 0 then
        self.immunityTimer = self.immunityTimer - dt
    end
    -- remove meteorites
    for index, meteorite in pairs(self.meteorites) do
        if meteorite.remove then
            table.remove(self.meteorites, index)
        end
    end

    -- remove o2
    for index, powerup in pairs(self.powerups) do
        if powerup.remove then
            table.remove(self.powerups, index)
        end
    end
end

function PlayState:render()
    -- render meteorite
    for index, meteorite in pairs(self.meteorites) do
        meteorite:render()
    end

    -- render powerup
    for index, powerup in pairs(self.powerups) do
        powerup:render()
    end
    
    -- render health bars
    for i = 0, self.astronaut.health - 1 do
        love.graphics.draw(gSprites['healthBar'], (i * 15) + 10, 10)
    end

    -- render o2 bar
    love.graphics.draw(gSprites['o2'], VIRTUAL_WIDTH - 75, 10)
    love.graphics.draw(gSprites['o2Bar'], VIRTUAL_WIDTH - 60, 10)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 59, 11, self.o2, 8)

    -- rendering astronaut
    self.astronaut:render()
end
