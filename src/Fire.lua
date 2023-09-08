Fire = Class{}

function Fire:init(x, alpha)
    self.x = x
    self.y = VIRTUAL_HEIGHT / 2 - 11

    self.dx = 0
    self.frame = 'fire1'
    self.frameCount = 1
    self.alpha = alpha / 255

    Timer.every(0.1, function()
        if self.frameCount == 3 then
            self.frameCount = 0
        end
        self.frameCount = self.frameCount + 1
    end)
end

function Fire:update(dt, dx)
    Timer.update(dt)
    self.frame = 'fire' .. tostring(self.frameCount)

    self.dx = dx
    self.x = self.x + self.dx * dt
end

function Fire:render()
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, self.alpha)
    love.graphics.draw(gSprites[self.frame], self.x, self.y)
end