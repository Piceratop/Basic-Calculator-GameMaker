global.cursor_alpha = 1;

if (label == "=") {
	load_answer();
} else if (ord(label) < ord("▲")) {
	switch (global.current_mode) {
		case "Practice":
			if (!obj_practice_controller.is_playing) {
				var _k = global.modes.Practice.option_id_mapping[| global.modes.Practice.current_option_id];
				global.modes.Practice.values_of_options[? _k][| 1] = input_equation(
					global.modes.Practice.values_of_options[? _k][| 0],
					label,
					global.modes.Practice.values_of_options[? _k][| 1]
				);
			}
			break;
		default:
			global.modes[$ global.current_mode].cursor_position = input_equation(
				global.modes[$ global.current_mode].current_equation,
				label,
				global.modes[$ global.current_mode].cursor_position
			);
			break;
	}
} else if (label == "▶" or label == "◀") {
	if (
		not struct_exists(global.modes[$ global.current_mode], "current_equation_id")
		or global.modes[$ global.current_mode].current_equation_id == 0
	) {
		switch (global.current_mode) {
			case "Practice":
				if (!obj_practice_controller.is_playing) {
					var _k = global.modes.Practice.option_id_mapping[| global.modes.Practice.current_option_id];
					global.modes.Practice.values_of_options[? _k][| 1] = navigate_equations(
						label,
						global.modes.Practice.values_of_options[? _k][| 1],
						ds_list_size(global.modes.Practice.values_of_options[? _k][| 0])
					);
				}
				break;
			default:
				global.modes[$ global.current_mode].cursor_position = navigate_equations(
					label,
					global.modes[$ global.current_mode].cursor_position,
					ds_list_size(global.modes[$ global.current_mode].current_equation)
				);
		}
	} else {
		var _l = ds_list_size(global.modes.Standard.equations);
		var _ci = ceil(global.modes.Standard.current_equation_id);
		var _id = _l - _ci;
		if (_ci == global.modes.Standard.current_equation_id) {
			global.modes.Standard.equations[| _id][| 2] = navigate_equations(
				label,
				global.modes.Standard.equations[| _id][| 2],
				ds_list_size(global.modes.Standard.equations[| _id][| 0])
			);
		} else {
			global.modes.Standard.equations[| _id][| 3] = navigate_equations(
				label,
				global.modes.Standard.equations[| _id][| 3],
				ds_list_size(global.modes.Standard.equations[| _id][| 1])
			);
		}
	}
} else if (label == "▲" or label == "▼") {
	switch (global.current_mode) {
		case "Standard":
			global.modes.Standard.current_equation_id = navigate_equations(
				label,
				global.modes.Standard.current_equation_id,
				ds_list_size(global.modes.Standard.equations),
				0.5
			);
			break;
		case "Practice":
			if (!obj_practice_controller.is_playing) {
				global.modes.Practice.current_option_id = navigate_equations(
					label,
					global.modes.Practice.current_option_id,
					ds_list_size(global.modes.Practice.option_id_mapping),
					-1
				);
			}
			break;
	}
}