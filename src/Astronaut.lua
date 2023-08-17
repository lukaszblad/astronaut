Astronaut = Class{}

function Astronaut:init()
    -- initial position centered
    self.x = VIRTUAL_WIDTH / 2 - 8
    self.y = VIRTUAL_HEIGHT / 2 - 10

    --sprite dimensions
    self.width = 16
    self.height = 20

    -- starting velocity at zero
    self.dx = 0
    self.dy = 0

    self.health = 3
    self.o2 = 49

    self.opacity = 255 / 255
end

function Astronaut:collideMeteorite(meteorite)
    -- detecti if one of the four sides of the astronaut is inside the hitbox of a meteorite
    -- upper side
    if (self.x + 2) + (self.width - 4) >= meteorite.x and self.x + 2 <= meteorite.x + meteorite.width then
        if (self.y + 2) + (self.height - 4) >= meteorite.y and self.y + 2 <= meteorite.y + meteorite.height then
            return true
        end
    end

    return false
end

function Astronaut:collidePowerUp(powerup)
    -- detecti if one of the four sides of the astronaut is inside the hitbox of a powerup
    if (self.x + 2) + (self.width - 4) >= powerup.x and self.x + 2 <= powerup.x + powerup.width then
        if (self.y + 2) + (self.height - 4) >= powerup.y and self.y + 2 <= powerup.y + powerup.height then
            return true
        end
    end

    return false
end

function Astronaut:update(dt, immunityTimer)
    if immunityTimer == 2 then
        self.opacity = 50 / 255
        self.health = self.health - 1
    elseif immunityTimer <= 0 then
        self.opacity = 255 / 255
    end
end

function Astronaut:render()
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, self.opacity)
    love.graphics.draw(gSprites['astronaut'], self.x, self.y)
end
