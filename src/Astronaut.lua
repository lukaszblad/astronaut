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
end

function Astronaut:collides(meteorite)
    --TODO
end

function Astronaut:update(dt)
    -- detect movement and update velocity
    -- progressive velocity to simulate hover in space
    if love.keyboard.isDown('up') then
        self.dy = self.dy - 1
    elseif love.keyboard.isDown('down') then
        self.dy = self.dy + 1
    elseif love.keyboard.isDown('left') then
        self.dx = self.dx - 1
    elseif love.keyboard.isDown('right') then
        self.dx = self.dx + 1
    end

    -- update coordinates with boundaries
    -- reset velocity if boundary hit
    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
        if self.x == 0 then
            self.dx = 0
        end
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
        if self.x == VIRTUAL_WIDTH - self.width then
            self.dx = 0
        end
    end

    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
        if self.y == 0 then
            self.dy = 0
        end
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
        if self.y == VIRTUAL_HEIGHT - self.height then
            self.dy = 0
        end
    end
end

function Astronaut:render()
    love.graphics.draw(gSprites['astronaut'], self.x, self.y)
end