HOTKEY = 'Ctrl+C'

button = nil
buttonWindow = nil

function init()
    buttonWindow = g_ui.displayUI('button')
	button = buttonWindow:recursiveGetChildById('button')
    button.onClick = function()
		--here call a function with a for loop modifying the x pos of button -1 and when it reaches <1 set to 500 and random y pos
        print('Button pos x=500 y=Random between 500 and 1')
    end

	
end

function terminate()
    buttonWindow:destroy()
end

function destroy()
    terminate()
end

function show()
    if g_game.isOnline() then
        buttonWindow:show()
        buttonWindow:raise()
        buttonWindow:focus()
    end
end