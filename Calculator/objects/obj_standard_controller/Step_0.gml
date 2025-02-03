// Checking Keyboard Input

if (
	keyboard_check_pressed(vk_anykey) and
	not array_contains([vk_alt, vk_lalt, vk_ralt, vk_control, vk_lcontrol, vk_rcontrol, vk_shift, vk_lshift, vk_rshift], keyboard_lastkey)
) {
	alarm[0] = game_get_speed(gamespeed_fps);
	global.cursor_alpha = 1;
	var _l = array_length(global.modes.Standard.equations);
	var _ci = ceil(global.modes.Standard.current_equation_id);
	var _id = _l - _ci;
	if (keyboard_lastkey == vk_backspace) {
		global.modes.Standard.current_equation_cursor_position = input_equation(global.modes.Standard.current_equation, "⌫", global.modes.Standard.current_equation_cursor_position);
	} else if (keyboard_lastkey == vk_right || keyboard_lastkey == vk_left) {
		var _direction = (keyboard_lastkey == vk_right) ? "▶" : "◀";
		if (global.modes.Standard.current_equation_id == 0)
			global.modes.Standard.current_equation_cursor_position = navigate_equations(
				_direction,
				global.modes.Standard.current_equation_cursor_position,
				ds_list_size(global.modes.Standard.current_equation)
			);
		else if (_ci == global.modes.Standard.current_equation_id) {
			global.modes.Standard.equations[_id][2] = navigate_equations(
				_direction,
				global.modes.Standard.equations[_id][2],
				ds_list_size(global.modes.Standard.equations[_id][0])
			);
		} else {
			global.modes.Standard.equations[_id][3] = navigate_equations(
				_direction,
				global.modes.Standard.equations[_id][3],
				ds_list_size(global.modes.Standard.equations[_id][1])
			);
		}
	} else if (keyboard_lastkey == vk_up)
		global.modes.Standard.current_equation_id = navigate_equations("▲", global.modes.Standard.current_equation_id, array_length(global.modes.Standard.equations));
	else if (keyboard_lastkey == vk_down)
		global.modes.Standard.current_equation_id = navigate_equations("▼", global.modes.Standard.current_equation_id, array_length(global.modes.Standard.equations));
	else if (keyboard_lastchar == "=" or keyboard_lastkey == vk_enter)
		load_answer();
	else if (keyboard_lastchar == "*")
		global.modes.Standard.current_equation_cursor_position = input_equation(
			global.modes.Standard.current_equation,
			"×",
			global.modes.Standard.current_equation_cursor_position
		)
	else if (keyboard_lastchar = "/")
		global.modes.Standard.current_equation_cursor_position = input_equation(
			global.modes.Standard.current_equation,
			"÷",
			global.modes.Standard.current_equation_cursor_position
		)
	else if (
		array_contains([
			"0", "1", "2", "3", "4",
			"5", "6", "7", "8", "9", 
			".", "+", "-", "(", ")"
		], keyboard_lastchar)
	) {
		global.modes.Standard.current_equation_cursor_position = input_equation(
			global.modes.Standard.current_equation,
			keyboard_lastchar,
			global.modes.Standard.current_equation_cursor_position
		);
	}
}

