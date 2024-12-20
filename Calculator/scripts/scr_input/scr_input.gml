function load_answer() {
	/**
	 * Ignore blank input.
	 */
	if (global.current_equation == "") return;
	
	var _equation_list = parse_equation(global.current_equation);
	var _ans_list = evaluate_equation(_equation_list);
	var _ans_str = "=" + parse_number(_ans_list);
	ds_list_destroy_multiple(_ans_list, _equation_list);
	
	/**
	 * Insert an array in the order:
	 * The equation, its answer, equation's cursor position,
	 * answer's cursor position.
	 */
	array_push(
		global.equations, 
		[
			global.current_equation, _ans_str,
			1 + string_length(global.current_equation),
			1 + string_length(_ans_str)
		]
	);
	global.current_equation = "";
	global.cursor_position = 1;
}

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

/**
 * @function				navigate_equations(_label)
 * @descrition				This function will navigate the cursor around the equations.
 * @param {String}		_label - The navigation button pressed
 * @return {Undefined} 
 */

function navigate_equations(_label) {
	var _equation_pos = array_length(global.equations) + global.current_equation_id;
	switch (_label) {
		case "▲":
			if (global.current_equation_id <= -3) return;
			global.current_equation_id = max(
				global.current_equation_id - 0.5,
				- array_length(global.equations)
			);
			return;
		case "◀":
			if (global.current_equation_id == 0)
				global.cursor_position = max(
					global.cursor_position - 1,
					1
				);
			else if (round(global.current_equation_id) == global.current_equation_id)
				global.equations[_equation_pos][2] = max(global.equations[_equation_pos][2] - 1, 1);
			else
				global.equations[_equation_pos][3] = max(global.equations[_equation_pos][3] - 1, 1);
			return;
		case "▼":
			global.current_equation_id = min(
				global.current_equation_id + 0.5,
				0
			);
			return;
		case "▶":
			if (global.current_equation_id == 0)
				global.cursor_position = min(
					global.cursor_position + 1,
					string_length(global.current_equation) + 1
				);
			else if (round(global.current_equation_id) == global.current_equation_id) {
				global.equations[_equation_pos][2] = min(
					global.equations[_equation_pos][2] + 1,
					string_length(global.equations[_equation_pos][0]) + 1
				);
			} else
				global.equations[_equation_pos][3] = min(
					global.equations[_equation_pos][3] + 1,
					string_length(global.equations[_equation_pos][1]) + 1
				);
			return;
	}
}