TitleState = Class{__includes = BaseState}

function TitleState:init()
    self.opacity = 255 / 255
    self.blink = 0
end

function TitleState:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('play')
    end

    if self.opacity <= 50 / 255 then
        self.blink = 2 / 255
    elseif self.opacity >= 255 / 255 then
        self.blink = - 2 / 255
    end

    self.opacity = self.opacity + self.blink

    background:scrolling(dt)
end

function TitleState:render()
    -- title text
    love.graphics.setFont(gFonts['big'])
    love.graphics.printf('Astronaut', 0, 100, VIRTUAL_WIDTH, 'center')

    -- press enter text
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, self.opacity)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press space to play', 0, 150, VIRTUAL_WIDTH, 'center')
end
