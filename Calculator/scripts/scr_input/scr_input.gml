function input_equation(_str, _label){
	var _curr_equation = "";
	if (typeof(_str) == "string")
		_curr_equation = _str;
	switch (_label) {
		case "⌫":
			_curr_equation = string_delete(
				_curr_equation,
				string_length(_curr_equation),
				1
			);
			global.display_text_start_pos -= 1;
			break;
		default:
			_curr_equation += _label;
			navigate_equations("▶");
	}
	return _curr_equation;
}

function navigate_equations(_label) {
	if (_label == "▶") {
		global.display_text_start_pos += 1;
		if (global.display_text_start_pos == 2)
			global.display_text_start_pos += 1;
	} else if (_label == "◀") {
		global.display_text_start_pos -= 1;
		if (global.display_text_start_pos == 2)
			global.display_text_start_pos -= 1;
	}
}