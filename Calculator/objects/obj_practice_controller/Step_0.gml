var _dropdown_mode = dropdown_get_value(dropdown_practice_mode);

if (!rendered_mode_choice) {
	global.modes.Practice.practice_mode = _dropdown_mode;
	rendered_mode_choice = true;
}

if (global.modes.Practice.practice_mode != _dropdown_mode) {
	rendered_mode_choice = false;
}