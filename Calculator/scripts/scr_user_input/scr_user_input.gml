/**
 * @function				handle_simple_numpad_input
 * @description			This function get the input from the numpad and modifying the current equation
 *								and the cursor position according to the current mode
 * @param {String}		_mode - The room mode to be handled
 * @return {Undefined}
 */
function numpad_check_simple_input(_mode=global.current_mode) {
	if (
		keyboard_check_pressed(vk_anykey) and
		not array_contains([
			vk_alt, vk_lalt, vk_ralt,
			vk_control, vk_lcontrol, vk_rcontrol,
			vk_shift, vk_lshift, vk_rshift
		], keyboard_lastkey)
	) {
		alarm[0] = game_get_speed(gamespeed_fps);
		global.cursor_alpha = 1;
		if (keyboard_lastkey == vk_backspace) {
			
			global.modes[$ _mode].cursor_position = input_equation(
				global.modes[$ _mode].current_equation,
				"⌫",
				global.modes[$ _mode].cursor_position
			);
		} else if (keyboard_lastkey == vk_right) {
			global.modes[$ _mode].cursor_position = navigate_equations(
				"▶",
				global.modes[$ _mode].cursor_position,
				ds_list_size(global.modes[$ _mode].current_equation)
			)
		} else if (keyboard_lastkey == vk_left) {
			global.modes[$ _mode].cursor_position = navigate_equations(
				"◀",
				global.modes[$ _mode].cursor_position,
				ds_list_size(global.modes[$ _mode].current_equation)
			)
	   } else if (keyboard_lastchar == "=" or keyboard_lastkey == vk_enter) {
			load_answer(_mode);
	   } else if (
			array_contains([
				"0", "1", "2", "3", "4",
				"5", "6", "7", "8", "9", 
				"."
			], keyboard_lastchar)
		) {
			global.modes[$ _mode].cursor_position = input_equation(
				global.modes[$ _mode].current_equation,
				keyboard_lastchar,
				global.modes[$ _mode].cursor_position
			);
		}
	}

}

/**
 * @function				load_answer
 * @description			This function processes the current equation based on the selected mode 
 *								(Converter or Standard) and updates the global state accordingly.
 * @param {String}		_mode - The mode to load the answer
 * @return {Undefined}
 */
function load_answer(_mode=global.current_mode) {
	switch (_mode) {
		case "Converter":
			/**
			 * Ignore blank input.
			 */
			if (ds_list_size(global.modes.Converter.current_equation) == 0) return;
			
			var _b = global.modes.Converter;
	      ds_list_destroy(_b.converted);
	      var _a = multiply(_b.current_equation, _b.conversion_rate[? _b.convert_mode][? _b.input_unit]);
	      _b.converted = divide(_a, _b.conversion_rate[? _b.convert_mode][? _b.output_unit], 6);
	      ds_list_destroy(_a);
			break;
			
		case "Standard":
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
				global.modes.Standard.displaying_equations, 
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
			while (array_length(global.modes.Standard.displaying_equations) > 5) {
				var _a = global.modes.Standard.equations[0][0];
				var _b = global.modes.Standard.equations[0][1];
				array_delete(global.modes.Standard.equations, 0, 1);
				ds_list_destroy_multiple(_a, _b);
				array_delete(global.modes.Standard.displaying_equations, 0, 1);
			}
	
		   json_save("save.bin", global.modes.Standard.displaying_equations);
			global.modes.Standard.current_equation = ds_list_create();
			global.modes.Standard.cursor_position = 0;
			break;
	}
}

/**
 * @function				input_equation
 * @description			This function modifies the given equation according to the input symbol and updates the cursor position.
 * @param {Id.DsList}	_curr_equation - The equation to be modified.
 * @param {String}		_label - The symbol to be inserted or the action to be performed (e.g., backspace).
 * @param {Real}			_pos - The position in the equation where the modification will occur.
 * @returns {Real}		The new cursor position after the modification.
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
 * @function			navigate_equations
 * @description		This function navigates the cursor around the equations based on the navigation button pressed.
 * @param {String}	_label - The navigation button pressed (e.g., ▲, ◀, ▼, ▶).
 * @param {Real}		_pos - The current cursor position.
 * @param {Real}		_pos_limit - The upper limit of the cursor position.
 * @returns {Real}	The new cursor position after navigation.
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