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
	// Get the current dropdown
	var _dropdown_id = collision_rectangle(
		mouse_x, mouse_y,
		mouse_x + 2, mouse_y + dropdown_height,
		self, false, false
	);
	
	// If the current dropdown exists, assign the current status to it
	if (_dropdown_id != noone && global.current_dropdown == noone) {
		global.current_dropdown = _dropdown_id;
		is_dropping = true;
	} else {
		if (id == global.current_dropdown) {
			global.current_dropdown = noone;
		}
		is_dropping = false;
	}
}