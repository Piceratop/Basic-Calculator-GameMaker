var _cur_equate = "";
if (typeof(global.current_equation) == "string")
	_cur_equate = global.current_equation;
switch (label) {
	case "⌫":
		_cur_equate = string_delete(
			_cur_equate,
			string_length(_cur_equate),
			1
		);
		if (string_char_at(_cur_equate, string_length(_cur_equate)) == "\n")
			_cur_equate = string_delete(
				_cur_equate,
				string_length(_cur_equate),
				1
			);
		break;
	default:
		if (string_length(_cur_equate) % 26 == 25)
			_cur_equate += "\n";
		_cur_equate += label;
}
global.current_equation = _cur_equate;