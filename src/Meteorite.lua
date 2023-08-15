Meteorite = Class{}

function Meteorite:init(str)
    self.sprite = gSprites[str]

    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()

    self.x = VIRTUAL_WIDTH + 10
    self.y = math.random(-400, VIRTUAL_HEIGHT + 400)

    self.dx = math.random(5, 15)
    self.dy = math.random (-10, 10)

    -- flag to indicate meteorites to be removed
    self.remove = false
end

function Meteorite:update(dt, backgroundDX, backgroundDY)
    self.x = self.x - self.dx * dt - backgroundDX / 10
    self.y = self.y + self.dy * dt + backgroundDY / 10

    -- update remove flag
    if (self.x + self.width < -10) or (self.y + self.height < -400) or (self.y > VIRTUAL_HEIGHT + 400) then
        self.remove = true
    end
end

function Meteorite:render()
    love.graphics.draw(self.sprite, self.x, self.y)
end
