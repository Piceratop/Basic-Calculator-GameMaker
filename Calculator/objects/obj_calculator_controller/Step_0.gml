if (keyboard_check_pressed(vk_anykey)) {
	if (
		ord(keyboard_lastchar) >= ord("0") and ord(keyboard_lastchar) <= ord("9")
		or keyboard_lastchar == "."
	)
		global.current_equation = input_equation(
			global.current_equation, keyboard_lastchar
		);
	else if (keyboard_lastkey == vk_backspace)
		global.current_equation = input_equation(
			global.current_equation, "⌫"
		)
}