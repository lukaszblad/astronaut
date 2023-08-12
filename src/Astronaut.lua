Astronaut = Class{}

function Astronaut:init()
    -- initial position centered
    self.x = VIRTUAL_WIDTH / 2 - 8
    self.y = VIRTUAL_HEIGHT / 2 - 10

    -- starting velocity at zero
    self.dx = 0
    self.dy = 0

    self.speed = 200
end

function Astronaut:update(dt)
    -- detect movement and update velocity
    if love.keyboard.isDown('w') then
        self.dy = -self.speed
    elseif love.keyboard.isDown('s') then
        self.dy = self.speed
    elseif love.keyboard.isDown('a') then
        self.dx = -self.speed
    elseif love.keyboard.isDown('d') then
        self.dx = self.speed
    else
        self.dx = 0
        self.dy = 0
    end

    -- update coordinates based on movement
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

end

function Astronaut:render()
    love.graphics.draw(gSprites['astronaut'], self.x, self.y)
end