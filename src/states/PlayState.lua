PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.astronaut = Astronaut(VIRTUAL_WIDTH / 2 - 8)
    self.meteorites = {[1] = Meteorite('meteorite5')}
    self.powerups = {[1] = PowerUp('o2Refill')}

    -- timer based features
    Timer.every(0.1, function() randomMeteorite = 'meteorite' .. tostring(math.random(11)) table.insert(self.meteorites, Meteorite(randomMeteorite)) end)
    Timer.every(0.15, function() self.astronaut.o2 = math.max(0, self.astronaut.o2 - 0.1) end)
    Timer.every(5, function() table.insert(self.powerups, PowerUp('mineral')) end)
    Timer.every(3, function() table.insert(self.powerups, PowerUp('o2Refill')) end)
    Timer.every(7, function() table.insert(self.powerups, PowerUp('healthRefill')) end)
    self.immunityTimer = 0
    self.o2HealthTimer = 0

    self.collectedMinerals = 0
end

function PlayState:update(dt)
    -- update background
        background:scrollX(dt)
        background:scrollY(dt)

    -- call timer functions
    Timer.update(dt)

    -- plutonium goal
    if self.collectedMinerals == 12 then
        gStateMachine:change('outro')
    end

    -- game over for health
    if self.astronaut.health == 0 then
        gStateMachine:change('gameover')
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
        -- detect collisions
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
            elseif powerup.type == 'mineral' then
                self.collectedMinerals = self.collectedMinerals + 1
                gSounds['plutonium']:play()
                table.remove(self.powerups, index)
            end
        end
    end

    -- updating astronaut after hit or after timeout
    if self.immunityTimer == 2 or self.immunityTimer <= 0 then
        self.astronaut:update(dt, self.immunityTimer)
    elseif self.immunityTimer < 2 and self.immunityTimer > 0 and self.astronaut.blue < 255 / 255 then
        self.astronaut.alpha = 55 / 255
        self.astronaut.blue = 255 / 255
        self.astronaut.green = 255 / 255
    end

    -- when oxygen terminated
    if self.astronaut.o2 <= 0 then
        self.astronaut.green = 255 / 255
        self.astronaut.blue = 255 / 255
        gSounds['alarm']:play()
        self.o2HealthTimer = self.o2HealthTimer + dt

        -- damage taken after 5 seconds
        if self.o2HealthTimer > 5 then
            self.astronaut.health = self.astronaut.health - 1
            gSounds['damage']:play()

            -- change the astronaut to red color for 1 frame
            self.astronaut.green = 0 / 255
            self.astronaut.blue = 0 / 255
            self.o2HealthTimer = 0
        end
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
    love.graphics.draw(gSprites['mineralBar'], VIRTUAL_WIDTH /2 - 25, 10)

    love.graphics.setColor(61 / 255, 189 / 255, 222 / 255)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 59, 11, self.astronaut.o2, 8)

    love.graphics.setColor(106 / 255, 190 / 255, 48 / 255, 255 / 255)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 24, 11, self.collectedMinerals * 4, 8)

    -- rendering astronaut
    self.astronaut:render()
end
