Astronaut = Class{}

function Astronaut:init(x)
    -- initial position centered
    self.x = x
    self.y = VIRTUAL_HEIGHT / 2 - 10

    --sprite dimensions
    self.width = 16
    self.height = 20

    -- starting velocity at zero
    self.dx = 50
    self.dy = 0

    self.health = 3
    self.o2 = 49

    self.red = 255 / 255
    self.green = 255 / 255
    self.blue = 255 / 255
    self.alpha = 255 / 255
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
    if self.x + self.width >= powerup.x and self.x <= powerup.x + powerup.width then
        if self.y + self.height >= powerup.y and self.y <= powerup.y + powerup.height then
            return true
        end
    end

    return false
end

function Astronaut:scroll(dt)
    self.x = self.x + self.dx * dt
end

function Astronaut:update(dt, immunityTimer)
    if immunityTimer == 2 then
        self.alpha = 50 / 255
        self.green = 0 / 255
        self.blue = 0 / 255
        self.health = self.health - 1
    elseif immunityTimer <= 0 then
        self.alpha = 255 / 255
        self.green = 255 / 255
        self.blue = 255 / 255
    end
end

function Astronaut:render()
    love.graphics.setColor(self.red, self.green, self.blue, self.alpha)
    love.graphics.draw(gSprites['astronaut'], self.x, self.y)
end
