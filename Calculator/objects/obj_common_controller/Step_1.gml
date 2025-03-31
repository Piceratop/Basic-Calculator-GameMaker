// Update the value of the current dropdown when it is pressed.
if (mouse_check_button_pressed(mb_left)) {
	with (global.current_dropdown) {
		for (var _i = 0; _i < count_showing_options; _i++) {
			var _by = y + _i * y_padding;
			if (
				mouse_y >= _by and mouse_y < _by + y_padding
				and mouse_x > x_left_side and mouse_x < x_left_side + dropdown_width - sprite_get_width(spr_scroll_button)
			) {
				current_option_id = idpos_current_scroll + _i;
				break;
			}
		}
	}
}