-- link to dependencies file
require 'src/Dependencies'

-- initializing astronaut
astronaut = Astronaut()

background = Background()

function love.load()
    -- removing blur filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- different seed for random functions at each launch
    math.randomseed(os.time())

    -- title of the window
    love.window.setTitle('Astronaut')

    -- initialize virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- loading the sprites into a table
    gSprites = {
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['astronaut'] = love.graphics.newImage('graphics/astronaut.png'),

        -- meteorites
        ['meteorite1'] = love.graphics.newImage('graphics/meteorite5px.png'),
        ['meteorite2'] = love.graphics.newImage('graphics/meteorite10px.png'),
        ['meteorite3'] = love.graphics.newImage('graphics/meteorite15px.png'),
        ['meteorite4'] = love.graphics.newImage('graphics/meteorite20px.png'),
        ['meteorite5'] = love.graphics.newImage('graphics/meteorite25px.png')
    }

    gStateMachine = StateMachine {
        ['title'] = function() return TitleState() end,
        ['play'] = function() return PlayState() end
    }
    gStateMachine:change('title')

    -- initialize input table
    love.keyboard.keysPressed = {}
end

-- function to monitor pressed keys
function love.keypressed(key)
    -- appending the pressed key
    love.keyboard.keysPressed[key] = true

    -- quit app when escape pressed
    if key == 'escape' then
        love.event.quit()
    end
end

-- function to store pressed keys
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    -- update current state
    gStateMachine:update(dt)

    -- clearing the pressed key table at each frame
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    -- render background
    background:render()

    -- render current state
    gStateMachine:render()

    push:finish()
end