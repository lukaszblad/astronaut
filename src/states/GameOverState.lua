GameOverState = Class{__includes = BaseState}

function GameOverState:init()
    -- TODO
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('title')
    end
    background:scrolling(dt)
end

function GameOverState:render()
    love.graphics.setFont(gFonts['big'])
    love.graphics.printf('Game Over', 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press space to return to title', 0, 150, VIRTUAL_WIDTH, 'center')
end
