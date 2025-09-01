#region Reset the displays when change the playing mode
var _dropdown_mode = dropdown_get_value(dropdown_practice_mode);

if (!rendered_mode_choice) {
	glb_practice.practice_mode = _dropdown_mode;
	glb_practice.current_option_id = 0;
	with (obj_display_box) { instance_destroy();	}
	with (obj_navigation_button) {
		if (name == "Practice_Play") { instance_destroy(); }
	}
	create_input_displays();
	rendered_mode_choice = true;
}

if (glb_practice.practice_mode != _dropdown_mode) {
	rendered_mode_choice = false;
}
#endregion

#region Update the displays of options
var _current_mode_options = glb_practice.option_id_mapping[? glb_practice.practice_mode];

with (obj_display_box) {
	for (
		var _k = ds_map_find_first(_current_mode_options);
		not is_undefined(_k);
		_k = ds_map_find_next(_current_mode_options, _k)
	) {
		if (name == _k) {
			value = parse_equation_from_single_list_to_string(_current_mode_options[? _k][| global.store_pos_equation]);
			cursor_position = _current_mode_options[? _k][| global.store_pos_equation_cursor];
		}
	}

	if (name == other.key_array[other.glb_practice.current_option_id]) {
		cursor_alpha = global.cursor_alpha;
	} else { cursor_alpha = 0; }
}
#endregion