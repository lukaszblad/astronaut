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
    love.graphics.printf('Astronaut', 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press space to play', 0, 150, VIRTUAL_WIDTH, 'center')
end