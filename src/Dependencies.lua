-- import external libraries
push = require 'lib/push'
Class = require 'lib/class'

--import local modules
require 'src/constants'

-- import internal classes
require 'src/Astronaut'
require 'src/Background'
require 'src/Meteorite'
require 'src/PowerUp'
require 'src/Spaceship'
require 'src/Fire'

-- import states
require 'StateMachine'
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/TitleState'
require 'src/states/GameOverState'
require 'src/states/IntroState'
require 'src/states/OutroState'