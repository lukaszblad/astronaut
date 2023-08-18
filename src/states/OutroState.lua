OutroState = Class{__includes = BaseState}

function OutroState:init()
    self.spaceship = Spaceship(VIRTUAL_WIDTH / 2 - 35, 75)
    self.astronaut = Astronaut(-20)
    self.fire = Fire(self.spaceship.x - 50, 0)
    self.timer = 0
end

function OutroState:update(dt)
    background:scrollX(dt)
    self.astronaut:scroll(dt)

    if self.astronaut.x >= VIRTUAL_WIDTH /2 - 75 then
        self.astronaut.dx = 0
        self.astronaut.alpha = 0 / 255
        self.timer = self.timer + dt
    end

    if self.timer > 2 then
        self.spaceship:scroll(dt)
        self.fire.alpha = 255 / 255
        self.fire:update(dt, self.spaceship.dx)
    end

    if self.spaceship.x > VIRTUAL_WIDTH + 60 then
        gStateMachine:change('title')
    end
end

function OutroState:render()
    self.astronaut:render()
    self.spaceship:render()
    self.fire:render()
end