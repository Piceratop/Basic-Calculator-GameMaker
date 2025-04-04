// Change the color of every object.
with (all) {
	image_blend = global.border_color;
}

// Handle dropdown clicking

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