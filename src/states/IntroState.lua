IntroState = Class{__includes = BaseState}

function IntroState:init()
    self.spaceship = Spaceship(-80, 35)
    self.fire = Fire(self.spaceship.x - 50, 255)

    self.timer = 0
    self.communication1 = ''
    self.communication2 = ''
    self.communication3 = ''

    self.blink = 0
    self.alpha = 255 / 255
end

function IntroState:update(dt)
    background:scrollX(dt)

    if self.spaceship.x < VIRTUAL_WIDTH / 4 - self.spaceship.width / 2 then
        self.spaceship:scroll(dt)
        self.fire:update(dt, self.spaceship.dx)
    elseif self.spaceship.x < VIRTUAL_WIDTH / 2 - self.spaceship.width / 2 - 10 then
        self.fire.alpha = 0 / 255
        self.spaceship:broken(dt)
        self.communication1 = 'Out of fuel search for some'
        self.communication2 = 'PLUTONIUM'
    else
        self.spaceship.dx = 0
        self.communication3 = 'Press space to play'

        if self.alpha <= 50 / 255 then
            self.blink = 2 / 255
        elseif self.alpha >= 255 / 255 then
            self.blink = - 2 / 255
        end
    
        self.alpha = self.alpha + self.blink

        if love.keyboard.wasPressed('space') then
            gStateMachine:change('play')
        end
    end
end

function IntroState:render()
    self.spaceship:render()
    self.fire:render()
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf(self.communication1, 0, 50, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(106 / 255, 190 / 255, 48 / 255, 255 / 255)
    love.graphics.printf(self.communication2, 0, 70, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, self.alpha)
    love.graphics.printf(self.communication3, 0, 250, VIRTUAL_WIDTH, 'center')
end 