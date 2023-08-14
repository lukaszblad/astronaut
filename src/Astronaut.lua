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
    -- TODO
end

function Astronaut:update(dt)
    -- TODO
end

function Astronaut:render()
    love.graphics.draw(gSprites['astronaut'], self.x, self.y)
end