if (label == "=") {
	load_answer();
	show_debug_message(global.equations[array_length(global.equations) - 1]);
} else if (ord(label) < ord("▲"))
	global.current_equation = input_equation(
		global.current_equation,
		label,
		global.cursor_position
	);
else navigate_equations(label);