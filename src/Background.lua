Background = Class{}

function Background:init(x)
    self.width = 1536
    self.height = 576

    self.x = 0
    self.y = -(self.height / 4) + 10

    self.loopingPointX = 1023
    self.dx = 0
    self.dy = 0
end

function Background:update(dt)
    -- update X scroll
    if love.keyboard.isDown('left') and self.dx > 0 then
        self.dx = self.dx - 0.15
    elseif love.keyboard.isDown('right') and self.dx < 16 then
        self.dx = self.dx + 0.15
    
    -- update Y scroll
    elseif love.keyboard.isDown('up') then
        self.dy = self.dy + 0.15
    elseif love.keyboard.isDown('down') then
        self.dy = self.dy - 0.15
    end

    -- scroll on axis X with looping
    self.x = (self.x + self.dx * dt) % self.loopingPointX
    
    --scroll on axis Y with boundaries
    -- if going up
    if self.dy > 0 then
        self.y = math.min(0, self.y + self.dy * dt)
        if self.y >= 0 then
            self.dy = 0
        end

    -- if going down
    elseif self.dy < 0 then
        self.y = math.max(-288, self.y + self.dy * dt)
        if self.y <= -288 then
            self.dy = 0
        end
    end

    -- self.y = self.y + self.dy * dt

    return self.dx, self.dy
end

function Background:render()
    love.graphics.draw(gSprites['background'], -self.x, self.y)
end
