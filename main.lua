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
        ['meteorite2px'] = love.graphics.newImage('graphics/meteorite2px.png'),
        ['meteorite3px'] = love.graphics.newImage('graphics/meteorite3px.png'),
        ['meteorite5px'] = love.graphics.newImage('graphics/meteorite5px.png'),
        ['meteorite10px'] = love.graphics.newImage('graphics/meteorite10px.png'),
        ['meteorite25px'] = love.graphics.newImage('graphics/meteorite25px.png')
    }

end

-- function to monitor pressed keys
function love.keypressed(key)

    -- quit app when escape pressed
    if key == 'escape' then
        love.event.quit()
    end

end

function love.update(dt)
    -- update astronaut
    astronautX = astronaut:update(dt)
    -- update background
    background:update(dt, astronautX)
end

function love.draw()
    push:start()

    -- render background
    love.graphics.draw(gSprites['background'], 0, 0)

    -- render background
    background:render()

    -- render astronaut
    astronaut:render()

    push:finish()
end