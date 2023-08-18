Fire = Class{}

function Fire:init(x, alpha)
    self.x = x
    self.y = VIRTUAL_HEIGHT / 2 - 11

    self.dx = 0
    self.count = 1
    self.frame = 'fire1'
    self.alpha = alpha / 255
end

function Fire:update(dt, dx)
    self.count = self.count + 1

    self.frame = 'fire' .. tostring(self.count)

    if self.count == 6 then
        self.count = 0
    end
    self.dx = dx
    self.x = self.x + self.dx * dt
end

function Fire:render()
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, self.alpha)
    love.graphics.draw(gSprites[self.frame], self.x, self.y)
end