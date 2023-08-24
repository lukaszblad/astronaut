Spaceship = Class{}

function Spaceship:init(x, dx)
    self.sprite = gSprites['spaceship']

    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
    
    self.x = x
    self.y = VIRTUAL_HEIGHT / 2 - self.height / 2

    self.dx = dx
    self.dy = 0
end

function Spaceship:scroll(dt)
    self.x = self.x + self.dx * dt
end

function Spaceship:broken(dt)
    self.dx = math.max(25, self.dx - 0.8)
    self.x = self.x + self.dx * dt
end

function Spaceship:render()
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
    love.graphics.draw(gSprites['spaceship'], self.x, self.y)
end