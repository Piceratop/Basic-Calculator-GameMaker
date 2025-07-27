// Change the color of every object.
with (all) {
	image_blend = global.border_color;
}
#region This code displays the menu according to the current state of the game.
update_layer();
#endregion

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

if (keyboard_check_pressed(vk_anykey)) {
   var _key = convert_keyboard_key_to_button_input();
   if (struct_exists(allowed_keys, global.current_mode)) {
     	handle_math_input(_key);
   }
   
   alarm[0] = game_get_speed(gamespeed_fps);
	global.cursor_alpha = 1;
   io_clear(); // Flush function keys
}

#endregion