if (ord(label) < ord("▲"))
	global.current_equation = input_equation(global.current_equation, label);
else navigate_equations(label);