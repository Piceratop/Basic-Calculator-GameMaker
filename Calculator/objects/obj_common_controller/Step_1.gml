// Update the value of the current dropdown when it is pressed.
if (mouse_check_button_pressed(mb_left)) {
	with (global.current_dropdown) {
		for (var _i = 0; _i < count_showing_options; _i++) {
			var _by = y + _i * dropdown_height;
			if (
				mouse_y >= _by + dropdown_height and mouse_y < _by + dropdown_height + dropdown_height
				and mouse_x > x and mouse_x < x + dropdown_width - sprite_get_width(spr_scroll_button)
			) {
				current_option_id = idpos_current_scroll + _i;
				break;
			}
		}
	}
}