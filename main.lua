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
        fullscreen = true,
        resizable = true
    })

    -- loading sounds
    gSounds = {
        ['space'] = love.audio.newSource('sounds/space.mp3', 'static'),
        ['damage'] = love.audio.newSource('sounds/damage.wav', 'static'),
        ['boundary'] = love.audio.newSource('sounds/boundary.wav', 'static'),
        ['powerup'] = love.audio.newSource('sounds/powerup.wav', 'static')
    }

    -- loading fonts
    gFonts = {
        ['small'] = love.graphics.newFont('fonts/fontSmall.ttf', 12),
        ['big'] = love.graphics.newFont('fonts/fontLarge.ttf', 32)
    }
    love.graphics.setFont(gFonts['small'])

    -- loading the sprites into a table
    gSprites = {
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['astronaut'] = love.graphics.newImage('graphics/astronaut.png'),
        ['healthBar'] = love.graphics.newImage('graphics/healthBar.png'),
        ['o2Bar'] = love.graphics.newImage('graphics/o2Bar.png'),
        ['o2'] = love.graphics.newImage('graphics/o2.png'),
        ['o2Refill'] = love.graphics.newImage('graphics/o2Refill.png'),
        ['healthRefill'] = love.graphics.newImage('graphics/healthRefill.png'),

        -- meteorites
        ['meteorite1'] = love.graphics.newImage('graphics/meteorite7px.png'),
        ['meteorite2'] = love.graphics.newImage('graphics/meteorite10px.png'),
        ['meteorite3'] = love.graphics.newImage('graphics/meteorite15px.png'),
        ['meteorite4'] = love.graphics.newImage('graphics/meteorite20px.png'), 
        ['meteorite5'] = love.graphics.newImage('graphics/meteorite25px.png')
    }

    gStateMachine = StateMachine {
        ['title'] = function() return TitleState() end,
        ['play'] = function() return PlayState() end,
        ['gameover'] = function() return GameOverState() end
    }
    gStateMachine:change('title')

    -- playiing space sounds in loop
    gSounds['space']:play()
    gSounds['space']:setLooping(true)

    -- initialize input table
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
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
