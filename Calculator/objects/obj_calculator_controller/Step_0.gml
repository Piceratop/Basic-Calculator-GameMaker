// Checking Keyboard Input

if (
	keyboard_check_pressed(vk_anykey) and
	not array_contains([vk_alt, vk_control, vk_shift], keyboard_lastkey)
) {
	alarm[0] = game_get_speed(gamespeed_fps);
	if (keyboard_lastkey == vk_backspace) {
		global.current_equation = input_equation(
			global.current_equation, "⌫", global.cursor_position
		);
	} else if (keyboard_lastkey == vk_right)
		navigate_equations("▶");
	else if (keyboard_lastkey == vk_left)
		navigate_equations("◀");
	else if (keyboard_lastkey == vk_up)
		navigate_equations("▲");
	else if (keyboard_lastkey == vk_down)
		navigate_equations("▼");
	else if (keyboard_lastchar == "=" or keyboard_lastkey == vk_enter)
		load_answer();
	else if (
		array_contains([
			"0", "1", "2", "3", "4",
			"5", "6", "7", "8", "9", 
			".", "+", "-", "*", "/",
		], keyboard_lastchar)
	) {
		global.current_equation = input_equation(
			global.current_equation, keyboard_lastchar, global.cursor_position
		);
	}
}