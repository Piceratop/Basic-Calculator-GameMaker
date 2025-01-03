obj_calculator_controller.cursor_alpha = 1;

if (label == "=") {
	load_answer();
} else if (ord(label) < ord("▲"))
	global.cursor_position = input_equation(
		global.current_equation,
		label,
		global.cursor_position
	);
else {
	if (label == "▶" or label == "◀") {
		if (global.current_equation_id == 0)
			global.cursor_position = navigate_equations(
				label,
				global.cursor_position,
				ds_list_size(global.current_equation)
			);
	}
}