-- link to dependencies file
require 'src/Dependencies'

-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- initialize astronaut speed
ASTRONAUT_SPEED = 200

-- initializing astronaut
astronaut = Astronaut()

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
        ['astronaut'] = love.graphics.newImage('graphics/astronaut.png')
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
    astronaut:update(dt)
end

function love.draw()
    push:start()

    -- render background
    love.graphics.draw(gSprites['background'], 0, 0)

    -- render astronaut
    astronaut:render()

    push:finish()
end