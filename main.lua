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
        ['space'] = love.audio.newSource('sounds/space.wav', 'static'),
        ['damage'] = love.audio.newSource('sounds/damage.wav', 'static'),
        ['powerup'] = love.audio.newSource('sounds/powerup.wav', 'static'),
        ['alarm'] = love.audio.newSource('sounds/alarm.wav', 'static'),
        ['plutonium'] = love.audio.newSource('sounds/plutonium.wav', 'static')
    }

    -- volume settings
    gSounds['alarm']:setVolume(0.1)
    gSounds['space']:setVolume(0.5)
    gSounds['powerup']:setVolume(0.1)
    gSounds['plutonium']:setVolume(0.1)

    -- playiing space sounds in loop
    gSounds['space']:play()
    gSounds['space']:setLooping(true)

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
        ['spaceship'] = love.graphics.newImage('graphics/spaceship.png'),
        ['mineral'] = love.graphics.newImage('graphics/mineral.png'),
        ['mineralBar'] = love.graphics.newImage('graphics/mineralBar.png'),

        -- fire animation
        ['fire1'] = love.graphics.newImage('graphics/fire1.png'),
        ['fire2'] = love.graphics.newImage('graphics/fire1.png'),
        ['fire3'] = love.graphics.newImage('graphics/fire2.png'),
        ['fire4'] = love.graphics.newImage('graphics/fire2.png'),
        ['fire5'] = love.graphics.newImage('graphics/fire3.png'),
        ['fire6'] = love.graphics.newImage('graphics/fire3.png'),

        -- meteorites
        ['meteorite1'] = love.graphics.newImage('graphics/meteorite1.png'),
        ['meteorite2'] = love.graphics.newImage('graphics/meteorite2.png'),
        ['meteorite3'] = love.graphics.newImage('graphics/meteorite3.png'),
        ['meteorite4'] = love.graphics.newImage('graphics/meteorite4.png'), 
        ['meteorite5'] = love.graphics.newImage('graphics/meteorite5.png'),
        ['meteorite6'] = love.graphics.newImage('graphics/meteorite6.png'),
        ['meteorite7'] = love.graphics.newImage('graphics/meteorite7.png'),
        ['meteorite8'] = love.graphics.newImage('graphics/meteorite8.png'),
        ['meteorite9'] = love.graphics.newImage('graphics/meteorite9.png'),
        ['meteorite10'] = love.graphics.newImage('graphics/meteorite10.png'),
        ['meteorite11'] = love.graphics.newImage('graphics/meteorite11.png')
    }

    gStateMachine = StateMachine {
        ['title'] = function() return TitleState() end,
        ['play'] = function() return PlayState() end,
        ['gameover'] = function() return GameOverState() end,
        ['intro'] = function() return IntroState() end,
        ['outro'] = function() return OutroState() end
    }
    gStateMachine:change('title')

    -- initialize input table
    love.keyboard.keysPressed = {}

    -- fps cap
    min_dt = 1/60 --fps
    next_time = love.timer.getTime()
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
    -- fps cap
    next_time = next_time + min_dt

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

    local cur_time = love.timer.getTime()
    if next_time <= cur_time then
       next_time = cur_time
       return
    end
    love.timer.sleep(next_time - cur_time)
end
