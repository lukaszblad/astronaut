StateMachine = Class{}

function StateMachine:init(states)
    self.empty = {
		render = function() end,
		update = function() end
	}
    self.states = states or {}
	self.current = self.empty
end

function StateMachine:change(stateName)
	assert(self.states[stateName])
	self.current = self.states[stateName]()
end

function StateMachine:update(dt)
	self.current:update(dt)
end

function StateMachine:render()
	self.current:render()
end
