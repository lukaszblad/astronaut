Background = Class{}

function Background:init(x)
    self.x = 0
    self.y = 0

    self.width = 1536
    self.loopingPoint = 1023
    self.dx = 0
end

function Background:update(dt)
    -- scroll if astronaut at 1/2 of width
    self.x = (self.x + self.dx * dt) % self.loopingPoint

    if love.keyboard.isDown('left') and self.dx > 0 then
        self.dx = self.dx - 0.15
    elseif love.keyboard.isDown('right') and self.dx < 16 then
        self.dx = self.dx + 0.18
    end 

    return self.dx
end

function Background:render()
    love.graphics.draw(gSprites['background'], -self.x, self.y)
end