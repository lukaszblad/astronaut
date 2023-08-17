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

    self.tolerance = 1
end

function Astronaut:collideMeteorite(meteorite)
    -- detecti if one of the four edges of astronaut is inside the hitbox of a meteorite
    -- upper left corner
    if self.x > meteorite.x + self.tolerance and self.y < meteorite.y + meteorite.height - self.tolerance and self.x < meteorite.x + meteorite.width - self.tolerance and self.y > meteorite.y + self.tolerance then
        return true

    -- bottome right corner
    elseif self.x + self.width > meteorite.x + self.tolerance and self.y + self.height < meteorite.y + meteorite.height - self.tolerance and self.x + self.width < meteorite.x + meteorite. width - self.tolerance and self.y + self.height > meteorite.y + self.tolerance then
        return true

    -- upper right corner
    elseif self.x + self.width > meteorite.x + self.tolerance and self.y > meteorite.y + self.tolerance and self.x + self.width < meteorite.x + meteorite.width - self.tolerance and self.y < meteorite.y + meteorite.height - self.tolerance then
        return true

    -- bottom left corner
    elseif self.x > meteorite.x + self.tolerance and self.y + self.height > meteorite.y + self.tolerance and self.x < meteorite.x + meteorite.width - self.tolerance and self.y + self.height < meteorite.y + meteorite.height - self.tolerance then
        return true
    end

    return false
end

function Astronaut:collidePowerUp(powerup)
    -- detecti if one of the four edges of astronaut is inside the hitbox of a powerup
    -- upper left corner
    if self.x > powerup.x and self.y < powerup.y + powerup.height and self.x < powerup.x + powerup.width and self.y > powerup.y then
        return true

    -- bottome right corner
    elseif self.x + self.width > powerup.x and self.y + self.height < powerup.y + powerup.height and self.x + self.width < powerup.x + powerup. width and self.y + self.height > powerup.y then
        return true

    -- upper right corner
    elseif self.x + self.width > powerup.x and self.y > powerup.y and self.x + self.width < powerup.x + powerup.width and self.y < powerup.y + powerup.height then
        return true

    -- bottom left corner
    elseif self.x > powerup.x and self.y + self.height > powerup.y and self.x < powerup.x + powerup.width and self.y + self.height < powerup.y + powerup.height then
        return true
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
