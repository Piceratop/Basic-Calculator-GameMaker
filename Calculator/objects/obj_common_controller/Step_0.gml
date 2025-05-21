// Change the color of every object.
with (all) {
	image_blend = global.border_color;
}

#region This code manages the dropdown.
if (mouse_check_button_pressed(mb_left)) {
	// Check whether the user presses on a navigation button.
	var _inst_scroll_nav_button = instance_position(mouse_x, mouse_y, obj_scroll_button);
	if (_inst_scroll_nav_button != noone) {
		with (global.current_dropdown) {
			switch (_inst_scroll_nav_button.type) {
				case "down":
					idpos_current_scroll = min(ds_list_size(options) - count_showing_options, idpos_current_scroll + 1);
					break;
				case "up":
					idpos_current_scroll = max(0, idpos_current_scroll - 1);
					break;
			}
		}
	} else if (global.current_dropdown == noone) {
		// This code opens a new dropdown there is no currently active dropdown.
		with (obj_dropdown) {
			if (
				collision_rectangle(
					mouse_x, mouse_y,
					mouse_x + 2, mouse_y + dropdown_height,
					self, false, false
				)
			) {
				global.current_dropdown = self;
			}
		}
		with (global.current_dropdown) {
			if (ds_list_size(options) > 0) {
				is_dropping = true;
			}
		}
	} else {
		with (global.current_dropdown) {
			is_dropping = false;
		}
		global.current_dropdown = noone;
	}
}
#endregion

#region This code handles keyboard input.

if (
	keyboard_check_pressed(vk_anykey) and
	not array_contains([vk_alt, vk_lalt, vk_ralt, vk_control, vk_lcontrol, vk_rcontrol, vk_shift, vk_lshift, vk_rshift], keyboard_lastkey)
) {
	alarm[0] = game_get_speed(gamespeed_fps);
	global.cursor_alpha = 1;
	
	if (keyboard_lastkey == vk_backspace) {
		global.modes[$ global.current_mode].cursor_position = input_equation(global.modes[$ global.current_mode].current_equation, "⌫", global.modes[$ global.current_mode].cursor_position);
	} else if (keyboard_lastkey == vk_right or keyboard_lastkey == vk_left) {
		var _direction = (keyboard_lastkey == vk_right) ? "▶" : "◀";
		if (global.current_mode != "Standard" or global.modes.Standard.current_equation_id == 0) {
			global.modes[$ global.current_mode].cursor_position = navigate_equations(
				_direction,
				global.modes[$ global.current_mode].cursor_position,
				ds_list_size(global.modes[$ global.current_mode].current_equation)
			);
		} else {
			var _l = ds_list_size(global.modes.Standard.equations);
			var _ci = ceil(global.modes.Standard.current_equation_id);
			var _id = _l - _ci;
			if (_ci == global.modes.Standard.current_equation_id) {
				global.modes.Standard.equations[| _id][| 2] = navigate_equations(
					_direction,
					global.modes.Standard.equations[| _id][| 2],
					ds_list_size(global.modes.Standard.equations[| _id][| 0])
				);
			} else {
				global.modes.Standard.equations[| _id][| 3] = navigate_equations(
					_direction,
					global.modes.Standard.equations[| _id][| 3],
					ds_list_size(global.modes.Standard.equations[| _id][| 1])
				);
			}
		}
	} else if (keyboard_lastkey == vk_up or keyboard_lastkey == vk_down) {
		var _direction = (keyboard_lastkey == vk_up) ? "▲" : "▼";
		if (global.current_mode == "Standard") {
			global.modes.Standard.current_equation_id = navigate_equations(
				_direction,
				global.modes.Standard.current_equation_id,
				ds_list_size(global.modes.Standard.equations),
				0.5
			);
		}
	} else if (keyboard_lastchar == "=" or keyboard_lastkey == vk_enter) {
		load_answer();
	} else if (keyboard_lastchar == "*") {
		global.modes[$ global.current_mode].cursor_position = input_equation(
			global.modes[$ global.current_mode].current_equation,
			"×",
			global.modes[$ global.current_mode].cursor_position
		);
	} else if (keyboard_lastchar = "/") {
		global.modes[$ global.current_mode].cursor_position = input_equation(
			global.modes[$ global.current_mode].current_equation,
			"÷",
			global.modes[$ global.current_mode].cursor_position
		);
	} else if (
		array_contains([
			"0", "1", "2", "3", "4",
			"5", "6", "7", "8", "9", 
			".", "+", "-", "(", ")"
		], keyboard_lastchar)
	) {
		global.modes[$ global.current_mode].cursor_position = input_equation(
			global.modes[$ global.current_mode].current_equation,
			keyboard_lastchar,
			global.modes[$ global.current_mode].cursor_position
		);
	}
}

#endregion