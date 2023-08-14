TitleState = Class{__includes = BaseState}

function TitleState:init()
    -- TODO
end

function TitleState:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('play')
    end
end

function TitleState:render()
    -- title text
    love.graphics.setFont(gFonts['big'])
    love.graphics.printf('Astronaut', 0, 100, VIRTUAL_WIDTH, 'center')

    -- press enter text
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press space to play', 0, 150, VIRTUAL_WIDTH, 'center')
end
