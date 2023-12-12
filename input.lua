-- input.lua

local state = require('state')

local press_functions = {
	escape = function()
		love.event.quit()
	end,
	space = function()
		state.paused = not state.paused
	end,
	backspace = function()
		love.event.quit("restart")
	end,
	up = function()
		state.up = not state.up
	end,
	down = function()
		state.down = not state.down
	end,
	right = function()
		state.rotate = not state.rotate
	end,
	left = function()
		state.rotate = not state.rotate
	end
}

return {
	press = function(pressed_key)
		if press_functions[pressed_key] then
			press_functions[pressed_key]()
		end
	end,
	release = function(released_key)
		if release_functions[released_key] then
			release_functions[released_key]()
		end
	end,
	toggle_focus = function(focused)
		if not focused then
			state.paused = true
		end
	end
}
