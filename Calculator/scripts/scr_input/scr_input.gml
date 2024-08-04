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
			break;
		default:
			_curr_equation += _label;
	}
	return _curr_equation;
}