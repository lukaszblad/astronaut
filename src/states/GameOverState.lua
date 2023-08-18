GameOverState = Class{__includes = BaseState}

function GameOverState:init()
    self.opacity = 255 / 255
    self.blink = 0
    background.dx = 15
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('play')
    end

    if self.opacity <= 50 / 255 then
        self.blink = 2 / 255
    elseif self.opacity >= 255 / 255 then
        self.blink = - 2 / 255
    end

    self.opacity = self.opacity + self.blink

    background:scrollX(dt)
end

function GameOverState:render()
    love.graphics.setFont(gFonts['big'])
    love.graphics.printf('Game Over', 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, self.opacity)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press space to play again', 0, 150, VIRTUAL_WIDTH, 'center')
end
