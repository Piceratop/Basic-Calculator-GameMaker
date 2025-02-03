global.cursor_alpha = 1;

if (label == "=") {
	load_answer();
} else if (ord(label) < ord("▲"))
	global.modes.Standard.current_equation_cursor_position = input_equation(
		global.modes.Standard.current_equation,
		label,
		global.modes.Standard.current_equation_cursor_position
	);
else if (label == "▶" or label == "◀") {
	if (global.modes.Standard.current_equation_id == 0)
		global.modes.Standard.current_equation_cursor_position = navigate_equations(
			label,
			global.modes.Standard.current_equation_cursor_position,
			ds_list_size(global.modes.Standard.current_equation)
		);
	else {
		var _l = array_length(global.modes.Standard.equations);
		var _ci = ceil(global.modes.Standard.current_equation_id);
		var _id = _l - _ci;
		if (_ci == global.modes.Standard.current_equation_id) {
			global.modes.Standard.equations[_id][2] = navigate_equations(
				label,
				global.modes.Standard.equations[_id][2],
				ds_list_size(global.modes.Standard.equations[_id][0])
			);
		} else {
			global.modes.Standard.equations[_id][3] = navigate_equations(
				label,
				global.modes.Standard.equations[_id][3],
				ds_list_size(global.modes.Standard.equations[_id][1])
			);
		}
	}
} else if (label == "▲" or label == "▼") {
	global.modes.Standard.current_equation_id = navigate_equations(
		label,
		global.modes.Standard.current_equation_id,
		array_length(global.modes.Standard.equations)
	);
}