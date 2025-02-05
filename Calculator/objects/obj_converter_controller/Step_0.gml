// Checking Keyboard Input

if (
	keyboard_check_pressed(vk_anykey) and
	not array_contains([vk_alt, vk_lalt, vk_ralt, vk_control, vk_lcontrol, vk_rcontrol, vk_shift, vk_lshift, vk_rshift], keyboard_lastkey)
) {
	alarm[0] = game_get_speed(gamespeed_fps);
	global.cursor_alpha = 1;
	if (keyboard_lastkey == vk_backspace)
		global.modes.Converter.cursor_position = input_equation(
			global.modes.Converter.convertee,
			"⌫",
			global.modes.Converter.cursor_position);
	else if (keyboard_lastkey == vk_right)
		global.modes.Converter.cursor_position = navigate_equations(
			"▶",
			global.modes.Converter.cursor_position,
			ds_list_size(global.modes.Converter.convertee)
		)
	else if (keyboard_lastkey == vk_left)
		global.modes.Converter.cursor_position = navigate_equations(
			"◀",
			global.modes.Converter.cursor_position,
			ds_list_size(global.modes.Converter.convertee)
		)
	else if (
		array_contains([
			"0", "1", "2", "3", "4",
			"5", "6", "7", "8", "9", 
			"."
		], keyboard_lastchar)
	)
		global.modes.Converter.cursor_position = input_equation(
			global.modes.Converter.convertee,
			keyboard_lastchar,
			global.modes.Converter.cursor_position
		);
}

