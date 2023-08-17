Background = Class{}

function Background:init()
    self.width = 1536
    self.height = 720

    self.x = 0
    self.y = -(self.height / 4) + 10

    self.loopingPointX = 1023
    self.loopingPointY = -431
    self.dx = 15
    self.dy = 0
end

-- scrolling for title state
function Background:scrolling(dt)
    self.x = (self.x + self.dx * dt) % self.loopingPointX
end

function Background:scrollX(dt)
    -- update X scroll
    if love.keyboard.isDown('left') and self.dx > 0 then
        self.dx = self.dx - 0.15
    elseif love.keyboard.isDown('right') and self.dx < 16 then
        self.dx = self.dx + 0.15
    end

    -- scroll on axis X with looping
    self.x = (self.x + self.dx * dt) % self.loopingPointX
end

function Background:scrollY(dt)
    -- update Y scroll
    if love.keyboard.isDown('up') and self.dy < 10 then
        self.dy = self.dy + 0.15
    elseif love.keyboard.isDown('down') and self.dy > -10 then
        self.dy = self.dy - 0.15
    end

    -- scroll on axis Y with boundaries
    self.y = (self.y + self.dy * dt) % self.loopingPointY
end

function Background:render()
    love.graphics.draw(gSprites['background'], -self.x, self.y)
end
