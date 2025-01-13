function load_answer() {
	/**
	 * Ignore blank input.
	 */
	if (ds_list_size(global.current_equation) == 0) return;
	
	var _equation_list = parse_equation_from_list_to_list(global.current_equation);
	var _ans_list = evaluate_equation(_equation_list);
	ds_list_destroy_all(_equation_list);
	
	/**
	 * Insert an array in the order:
	 * The equation, its answer, equation's cursor position,
	 * answer's cursor position.
	 */
	array_push(
		global.equations, 
		[
			parse_equation_from_single_list_to_string(global.current_equation), 
			parse_equation_from_single_list_to_string(_ans_list),
			ds_list_size(global.current_equation),
			ds_list_size(_ans_list)
		]
	);
	
	// Remove the oldest one if the save is too long.
	if (array_length(global.equations) > 5) {
		array_delete(global.equations, 0, 1);
	}
	
   json_save("save.bin", global.equations);
	global.current_equation = ds_list_create();
	global.cursor_position = 0;
}

/**
 * @function				input_equation(_curr_equation, _label, _pos)
 * @descrition				This function will modify the equation according to the input.
 * @param {Id.DsList}	_curr_equation - The equation to be modified
 * @param {String}		_label - The symbol needs to be inserted.
 * @param {Real}			_pos - The position of the going-to-be-modified equation.
 */

function input_equation(_curr_equation, _label, _pos) {
	switch (_label) {
		case "⌫":
			if (_pos == 0)
				ds_list_delete(_curr_equation, 0);
			else {
				_pos -= 1;
				ds_list_delete(_curr_equation, _pos);
			}
			return _pos;
		default:
			ds_list_insert(_curr_equation, _pos, global.math_encoding_map[? _label]);
			return _pos + 1;
	}
}

/**
 * @function				navigate_equations(_label)
 * @descrition				This function will navigate the cursor around the equations.
 * @param {String}		_label - The navigation button pressed
 * @param {Real}			_pos - The current cursor position
 * @param {Real}			_pos_limit - The upper limit of _cursor_pos
 */

function navigate_equations(_label, _pos, _pos_limit) {
	switch (_label) {
		case "▲":
			return min(_pos_limit, _pos + 0.5) 
		case "◀":
			return max(0, _pos - 1);
		case "▼":
			return max(0, _pos - 0.5);
		case "▶":
			return min(_pos_limit, _pos + 1);
	}
}