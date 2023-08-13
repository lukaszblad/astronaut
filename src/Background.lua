Background = Class{}

function Background:init(x)
    self.x = 0
    self.y = 0

    self.width = 1536
    self.loopingPoint = 1023
    self.dx = 15

end

function Background:update(dt, astronautX)
    -- scroll if astronaut at 1/2 of width
    if astronautX > VIRTUAL_WIDTH / 2 - 8 then
        self.x = (self.x + self.dx * dt) % self.loopingPoint
    end
end

function Background:render()
    love.graphics.draw(gSprites['background'], -self.x, self.y)
end