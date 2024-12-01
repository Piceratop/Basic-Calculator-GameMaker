if (label == "=") {
	
} else if (ord(label) < ord("▲"))
	global.current_equation = input_equation(
		global.current_equation,
		label,
		global.cursor_position
	);
else navigate_equations(label);