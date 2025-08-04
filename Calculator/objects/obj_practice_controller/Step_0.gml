var _dropdown_mode = dropdown_get_value(dropdown_practice_mode);

if (!rendered_mode_choice) {
	global.modes.Practice.practice_mode = _dropdown_mode;
	rendered_mode_choice = true;
}

if (global.modes.Practice.practice_mode != _dropdown_mode) {
	rendered_mode_choice = false;
}

// This code updates the values of the options

var _p = global.modes.Practice;
with (obj_display_box) {
	for (var _i = 0; _i < ds_list_size(_p.option_id_mapping); _i++) {
		if (name == _p.option_id_mapping[| _i]) {
			value = parse_equation_from_single_list_to_string(_p.values_of_options[? _p.option_id_mapping[| _i]][| 0]);
			cursor_position = _p.values_of_options[? _p.option_id_mapping[| _i]][| 1];
		}
	}
	if (name == _p.option_id_mapping[| _p.current_option_id]) {
		cursor_alpha = global.cursor_alpha;
	} else { cursor_alpha = 0; }
}