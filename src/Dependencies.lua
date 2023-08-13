-- import external libraries
push = require 'lib/push'
Class = require 'lib/class'

--import local modules
require 'src/constants'

-- import internal classes
require 'src/Astronaut'
require 'src/Background'
require 'src/Meteorite'

-- import states
require 'StateMachine'
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/TitleState'
