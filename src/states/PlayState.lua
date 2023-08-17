PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.astronaut = Astronaut()
    self.meteorites = {[1] = Meteorite('meteorite5')}
    self.powerups = {[1] = PowerUp('o2Refill')}

    self.meteoriteTimer = 0
    self.immunityTimer = 0
    self.o2SpawnTimer = 0
    self.o2HealthTimer = 0
    self.healthTimer = 0
end

function PlayState:update(dt)
    -- update background
        background:scrollX(dt)
        background:scrollY(dt)

    if self.astronaut.health == 0 then
        gStateMachine:change('gameover')
    end
    
    -- spawn new meteorites
    self.meteoriteTimer = self.meteoriteTimer + dt
    if self.meteoriteTimer > 0.1 then
        randomMeteorite = 'meteorite' .. tostring(math.random(11))
        table.insert(self.meteorites, Meteorite(randomMeteorite))

        -- reducing o2 level
        if self.astronaut.o2 > 0 then
            self.astronaut.o2 = self.astronaut.o2 - 0.1
        end
        -- resetting timer
        self.meteoriteTimer = 0
    end

    -- spawn oxygen
    self.o2SpawnTimer = self.o2SpawnTimer + dt
    if self.o2SpawnTimer > 3 then
        table.insert(self.powerups, PowerUp('o2Refill'))
        self.o2SpawnTimer = 0
    end

    -- spawn health
    self.healthTimer = self.healthTimer + dt
    if self.healthTimer > 5 then
        table.insert(self.powerups, PowerUp('healthRefill'))
        self.healthTimer = 0
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
            if powerup.type == 'o2Refill' then
                if self.astronaut.o2 >= 39 then
                    self.astronaut.o2 = 49
                else
                    self.astronaut.o2 = self.astronaut.o2 + 10
                end
                gSounds['powerup']:play()
                table.remove(self.powerups, index)
            elseif powerup.type == 'healthRefill' then
                self.astronaut.health = self.astronaut.health + 1
                gSounds['powerup']:play()
                table.remove(self.powerups, index)
            end
        end
    end

    -- update health when out of oxygen
    if self.astronaut.o2 <= 0 then
        gSounds['alarm']:play()
        self.o2HealthTimer = self.o2HealthTimer + dt
        if self.o2HealthTimer > 5 then
            self.astronaut.health = self.astronaut.health - 1
            gSounds['damage']:play()
            self.o2HealthTimer = 0
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

    -- remove powerup
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

    love.graphics.setColor(61 / 255, 189 / 255, 222 / 255)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 59, 11, self.astronaut.o2, 8)

    -- rendering astronaut
    self.astronaut:render()
end
