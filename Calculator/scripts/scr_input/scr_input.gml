function load_answer() {
	/**
	 * Ignore blank input.
	 */
	if (ds_list_size(global.modes.Standard.current_equation) == 0) return;
	
	/**
	 * Evaluate the equation, and if the evaluation succeeds, store it in the Ans variable.
	 */
	var _equation_list = parse_equation_from_list_to_list(global.modes.Standard.current_equation);
	var _ans_list = evaluate_equation(_equation_list);
	ds_list_destroy_all(_equation_list);
	
	if (_ans_list[| 0] != -1)
		ds_list_copy(global.Ans, _ans_list);
	
	/**
	 * Insert an array in the order:
	 * The equation, its answer, equation's cursor position,
	 * answer's cursor position.
	 */
	array_push(
		global.modes.Standard.displaying_equation, 
		[
			parse_equation_from_single_list_to_string(global.modes.Standard.current_equation), 
			parse_equation_from_single_list_to_string(_ans_list),
			0,
			ds_list_size(_ans_list)
		]
	);
	array_push(
		global.modes.Standard.equations,
		[
			global.modes.Standard.current_equation, _ans_list,
			0, ds_list_size(_ans_list)
		]
	);
		
	
	// Remove the oldest one if the save is too long.
	while (array_length(global.modes.Standard.displaying_equation) > 5) {
		var _a = global.modes.Standard.equations[0][0];
		var _b = global.modes.Standard.equations[0][1];
		array_delete(global.modes.Standard.equations, 0, 1);
		ds_list_destroy_multiple(_a, _b);
		array_delete(global.modes.Standard.displaying_equation, 0, 1);
	}
	
   json_save("save.bin", global.modes.Standard.displaying_equation);
	global.modes.Standard.current_equation = ds_list_create();
	global.modes.Standard.current_equation_cursor_position = 0;
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
			ds_list_insert(_curr_equation, _pos, global.math_encodings[? _label]);
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