// Scrolling handling

if (is_dropping) {
	if (mouse_wheel_down()) {
		idpos_current_scroll = min(ds_list_size(options) - count_showing_options, idpos_current_scroll + 1);
	}
	if (mouse_wheel_up()) {
      idpos_current_scroll = max(0, idpos_current_scroll - 1);
	}
}

// Handle dropdown clicking

if (mouse_check_button_pressed(mb_left)) {
	// Update the value of the current dropdown.
	with (global.current_dropdown) {
		for (var _i = 0; _i < count_showing_options; _i++) {
			var _by = y + _i * y_padding;
			if (
				mouse_y >= _by and mouse_y < _by + y_padding
				and mouse_x > margin and mouse_x < room_width - margin - sprite_get_width(spr_scroll_button)
			) {
				current_option_id = idpos_current_scroll + _i;
				break;
			}
		}
	}
	
	// Check whether the user presses on a navigation button.
	var _inst_scroll_nav_button = instance_position(mouse_x, mouse_y, obj_scroll_button);
	if (_inst_scroll_nav_button != noone) {
		if (id == global.current_dropdown) {
			switch (_inst_scroll_nav_button.type) {
				case "down":
					idpos_current_scroll = min(ds_list_size(options) - count_showing_options, idpos_current_scroll + 1);
					break;
				case "up":
					idpos_current_scroll = max(0, idpos_current_scroll - 1);
					break;
			}
		}
	} else {
		// Check for any collision with a dropdown and whether there is no currently active dropdown.
		global.current_dropdown = collision_rectangle(
			mouse_x, mouse_y,
			mouse_x + 2, mouse_y + dropdown_height,
			obj_dropdown, false, false
		);
		if (id == global.current_dropdown) {
			is_dropping = true;
		} else {
			is_dropping = false;
		}
	}	
}