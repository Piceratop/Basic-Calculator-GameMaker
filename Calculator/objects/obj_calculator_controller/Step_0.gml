// Checking Keyboard Input

if (keyboard_check_pressed(vk_anykey)) {
	if (keyboard_lastkey == vk_backspace)
		global.current_equation = input_equation(
			global.current_equation, "⌫", global.cursor_position
		)
	
	else if (keyboard_lastkey == vk_right) {
		navigate_equations("▶");
	} else if (keyboard_lastkey == vk_left)
		navigate_equations("◀");
	else if (keyboard_lastchar == "=") {
		
	}
	else if (
		ord(keyboard_lastchar) >= ord("0") and ord(keyboard_lastchar) <= ord("9")
		or array_contains([".", "+", "-", "*", "/"], keyboard_lastchar)
	) {
		global.current_equation = input_equation(
			global.current_equation, keyboard_lastchar, global.cursor_position
		);
	}
}