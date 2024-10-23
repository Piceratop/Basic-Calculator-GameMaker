function input_equation(_curr_equation, _label, _pos) {
	switch (_label) {
		case "⌫":
			_curr_equation = string_delete(_curr_equation, _pos - 1, 1);
			global.cursor_position -= 2;
			break;
		case "-":
			_curr_equation = string_insert("−", _curr_equation, _pos);
			break;
		case "*":
			_curr_equation = string_insert("×", _curr_equation, _pos);
			break;
		case "/":
			_curr_equation = string_insert("÷", _curr_equation, _pos);
			break;
		default:
			_curr_equation = string_insert(_label, _curr_equation, _pos);
	}
	global.cursor_position += 1;
	if (global.cursor_position < 1)
		global.cursor_position = 1;
	return _curr_equation;
}

function navigate_equations(_label) {
	if (_label == "◀") {
		global.cursor_position -= 1;
		if (global.cursor_position < 1)
			global.cursor_position = 1;
	} else if (_label == "▶") {
		global.cursor_position += 1;
		if (global.cursor_position > 1 + string_length(global.current_equation))
			global.cursor_position = string_length(global.current_equation) + 1;
	}
}