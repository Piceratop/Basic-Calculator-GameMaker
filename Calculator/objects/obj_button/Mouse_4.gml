obj_calculator_controller.cursor_alpha = 1;

if (label == "=") {
	load_answer();
} else if (ord(label) < ord("▲"))
	global.cursor_position = input_equation(
		global.current_equation,
		label,
		global.cursor_position
	);
else if (label == "▶" or label == "◀") {
	if (global.current_equation_id == 0)
		global.cursor_position = navigate_equations(
			label,
			global.cursor_position,
			ds_list_size(global.current_equation)
		);
	else {
		var _l = array_length(global.equations);
		var _ci = ceil(global.current_equation_id);
		var _id = _l - _ci;
		if (_ci == global.current_equation_id) {
			global.equations[_id][2] = navigate_equations(
				label,
				global.equations[_id][2],
				ds_list_size(global.equations[_id][0])
			);
		} else {
			global.equations[_id][3] = navigate_equations(
				label,
				global.equations[_id][3],
				ds_list_size(global.equations[_id][1])
			);
		}
	}
} else if (label == "▲" or label == "▼") {
	global.current_equation_id = navigate_equations(
		label,
		global.current_equation_id,
		array_length(global.equations)
	);
}