Background = Class{}

function Background:init()
    self.width = 1536
    self.height = 432

    self.x = 0
    self.y = -(self.height / 4) + 10

    self.loopingPointX = 1023
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
    if love.keyboard.isDown('up') then
        self.dy = self.dy + 0.15
    elseif love.keyboard.isDown('down') then
        self.dy = self.dy - 0.15
    end

    -- scroll on axis Y with boundaries
    -- if going up
    if self.dy > 0 then
        self.y = math.min(0, self.y + self.dy * dt)
        if self.y >= 0 then
            self.dy = -self.dy / 4
            gSounds['boundary']:play()
        end

    -- if going down
    elseif self.dy < 0 then
        self.y = math.max(-144, self.y + self.dy * dt)
        if self.y <= -144 then
            self.dy = -self.dy / 4
            gSounds['boundary']:play()
        end
    end
end

function Background:render()
    love.graphics.draw(gSprites['background'], -self.x, self.y)
end
