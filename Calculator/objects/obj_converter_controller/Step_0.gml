// Checking Keyboard Input
if (
	keyboard_check_pressed(vk_anykey) and
	not array_contains([vk_alt, vk_lalt, vk_ralt, vk_control, vk_lcontrol, vk_rcontrol, vk_shift, vk_lshift, vk_rshift], keyboard_lastkey)
) {
	alarm[0] = game_get_speed(gamespeed_fps);
	global.cursor_alpha = 1;
	if (keyboard_lastkey == vk_backspace)
		global.modes.Converter.cursor_position = input_equation(
			global.modes.Converter.current_equation,
			"⌫",
			global.modes.Converter.cursor_position);
	else if (keyboard_lastkey == vk_right)
		global.modes.Converter.cursor_position = navigate_equations(
			"▶",
			global.modes.Converter.cursor_position,
			ds_list_size(global.modes.Converter.current_equation)
		)
	else if (keyboard_lastkey == vk_left)
		global.modes.Converter.cursor_position = navigate_equations(
			"◀",
			global.modes.Converter.cursor_position,
			ds_list_size(global.modes.Converter.current_equation)
		)
   else if (keyboard_lastchar == "=") {
      //ds_list_destroy(global.modes.Converter.converted);
      //var _a = multiply(global.modes.Converter.current_equation, global.modes.Converter.conversion_rate[? global.modes.Converter.convert_mode]);
      //show_debug_message(ds_list_stringify(_a));
      //ds_list_destroy(_a);
   } else if (
		array_contains([
			"0", "1", "2", "3", "4",
			"5", "6", "7", "8", "9", 
			"."
		], keyboard_lastchar)
	)
		global.modes.Converter.cursor_position = input_equation(
			global.modes.Converter.current_equation,
			keyboard_lastchar,
			global.modes.Converter.cursor_position
		);
}

// Checking for dropdowns and update converting units
if (mouse_check_button_pressed(mb_left)) {
	var _dropdown_id = collision_rectangle(mouse_x, mouse_y, mouse_x + 2, mouse_y + box_height, obj_dropdown, false, false);
	if (_dropdown_id != noone && current_dropdown == noone) {
		current_dropdown = _dropdown_id;
		with (_dropdown_id)
			is_dropping = true;
	} else {
		with (current_dropdown) {
			for (var _i = 0; _i < 3; _i++) {
				var _by = y + _i * y_padding;
				if (mouse_y >= _by and mouse_y < _by + y_padding) {
					current_option_id = current_scroll_pos + _i;
					break;
				}
			}
			if (name == "input")
				global.modes.Converter.input_unit = options[| current_option_id];
		}
		with (obj_dropdown)
			is_dropping = false;
		current_dropdown = noone;
	}
}