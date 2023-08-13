Meteorite = Class{}

function Meteorite:init(str)
    self.sprite = gSprites[str]

    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()

    self.x = VIRTUAL_WIDTH + 10
    self.y = math.random(-2, VIRTUAL_HEIGHT -2)

    self.dx = math.random(5, 10)
    self.dy = math.random (-5, 5)
end

function Meteorite:update(dt, backgroundVelocity)
    self.x = self.x - self.dx * dt - backgroundVelocity / 10
    self.y = self.y + self.dy * dt
end

function Meteorite:render()
    love.graphics.draw(self.sprite, self.x, self.y)
end