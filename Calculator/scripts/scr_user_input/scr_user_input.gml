#macro STANDARD_NAV_STEP 0.5 // Half-step for input/output switching
#macro PRACTICE_NAV_MODE_STEP -1

function is_practice_mode_playing() {
   return obj_practice_controller.is_playing;
}

function handle_equation_input(_key, _mode) {
   if (_mode == "Practice" and !is_practice_mode_playing()) {
      var _practice = global.modes.Practice;
      var _option_key = _practice.option_id_mapping[| _practice.current_option_id];
      var _option_data = _practice.values_of_options[? _option_key];
      
      _option_data[| store_id_meaning.lhs_cursor_index] = input_equation(
         _option_data[| store_id_meaning.lhs_data],
         _key,
         _option_data[| store_id_meaning.lhs_cursor_index]
      );
   } else {
      var _current_mode = global.modes[$ _mode];
      
      _current_mode.cursor_position = input_equation(
         _current_mode.current_equation,
         _key,
         _current_mode.cursor_position
      );
   }
}

function handle_vertical_navigation(_key, _mode) {
   switch (_mode) {
      case "Standard":
         global.modes.Standard.current_equation_id = navigate_equations(
            _key,
            global.modes.Standard.current_equation_id,
            ds_list_size(global.modes.Standard.equations),
            STANDARD_NAV_STEP 
         );
         break;
      case "Practice":
         if (!is_practice_mode_playing()) {
            global.modes.Practice.current_option_id = navigate_equations(
               _key,
               global.modes.Practice.current_option_id,
               ds_list_size(global.modes.Practice.option_id_mapping),
               PRACTICE_NAV_MODE_STEP
            );
         }
         break;
   }
}

/**
 * @description			This function get the input from the numpad and modifying the current equation
 *								and the cursor position according to the current mode
 * @param {String}		_key - The label of the key pressed
 * @param {String}		_mode - The room mode to be handled
 * @return {Undefined}
 */
function handle_math_input(_key="", _mode=global.current_mode) {
	global.cursor_alpha = 1;
   enum store_id_meaning {
      lhs_data,
      lhs_cursor_index,
      rhs_data,
      rhs_cursor_index
   }
   
   switch(_key) {
      case "=":
         load_answer();
         break;
      
      case "0":
      case "1":
      case "2":
      case "3":
      case "4":
      case "5":
      case "6":
      case "7":
      case "8":
      case "9":
      case ".":
      case "+":
      case "−":
      case "×":
      case "÷": 
      case "-":
      case "(":
      case ")":
      case "⌫":
         handle_equation_input(_key, _mode);
         break;
      
      case "▶":
      case "◀":
         if (
   		not struct_exists(global.modes[$ global.current_mode], "current_equation_id")
   		or global.modes[$ global.current_mode].current_equation_id == 0
   	) {
   		switch (global.current_mode) {
   			case "Practice":
   				if (!obj_practice_controller.is_playing) {
   					var _k = global.modes.Practice.option_id_mapping[| global.modes.Practice.current_option_id];
   					global.modes.Practice.values_of_options[? _k][| 1] = navigate_equations(
   						_key,
   						global.modes.Practice.values_of_options[? _k][| 1],
   						ds_list_size(global.modes.Practice.values_of_options[? _k][| 0])
   					);
   				}
   				break;
   			default:
   				global.modes[$ global.current_mode].cursor_position = navigate_equations(
   					_key,
   					global.modes[$ global.current_mode].cursor_position,
   					ds_list_size(global.modes[$ global.current_mode].current_equation)
   				);
   		}
   	} else {
   		var _l = ds_list_size(global.modes.Standard.equations);
   		var _ci = ceil(global.modes.Standard.current_equation_id);
   		var _id = _l - _ci;
   		if (_ci == global.modes.Standard.current_equation_id) {
   			global.modes.Standard.equations[| _id][| 2] = navigate_equations(
   				_key,
   				global.modes.Standard.equations[| _id][| 2],
   				ds_list_size(global.modes.Standard.equations[| _id][| 0])
   			);
   		} else {
   			global.modes.Standard.equations[| _id][| 3] = navigate_equations(
   				_key,
   				global.modes.Standard.equations[| _id][| 3],
   				ds_list_size(global.modes.Standard.equations[| _id][| 1])
   			);
   		}
   	}
         break;
      case "▲":
      case "▼":
         handle_vertical_navigation(_key, _mode);
         break;
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
			var _b = global.modes.Converter;
	      ds_list_destroy(_b.converted);
         if (ds_list_size(global.modes.Converter.current_equation) == 0) {
   			// If a blank input is given, return a clean the output
            _b.converted = ds_list_create();
         } else {
            // Calculate and assign the result to the output.
   	      var _a = multiply(_b.current_equation, _b.conversion_rate[? _b.convert_mode][? _b.input_unit]);
   	      _b.converted = divide(_a, _b.conversion_rate[? _b.convert_mode][? _b.output_unit], 6);
   	      ds_list_destroy(_a);
         }
			return;
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
	
			if (_ans_list[| 0] != -1) {
				ds_list_copy(global.Ans, _ans_list);
			}

			/**
			 * Insert a ds_list in the order:
			 * The equation, its answer, the equation's cursor position,
			 * the answer's cursor position.
			 */

			var _disp_data = ds_list_create();
			ds_list_add(
				_disp_data,
				parse_equation_from_single_list_to_string(global.modes.Standard.current_equation),
				parse_equation_from_single_list_to_string(_ans_list),
				0,
				ds_list_size(_ans_list)
			);
			var _disp_equations = global.modes.Standard.displaying_equations;
			ds_list_add(global.modes.Standard.displaying_equations, _disp_data);
			ds_list_mark_as_list(
				global.modes.Standard.displaying_equations,
				ds_list_size(global.modes.Standard.displaying_equations) - 1
			);
			
			var _data = ds_list_create();
			ds_list_add(_data, global.modes.Standard.current_equation, _ans_list, 0, ds_list_size(_ans_list));
			ds_list_mark_as_list(_data, 0);
			ds_list_mark_as_list(_data, 1);
			ds_list_add(global.modes.Standard.equations, _data);
	
			// Remove the oldest one if the save is too long.
			while (ds_list_size(global.modes.Standard.displaying_equations) > 5) {
				var _a = global.modes.Standard.equations[| 0][| 0];
				var _b = global.modes.Standard.equations[| 0][| 1];
				var _c = global.modes.Standard.equations[| 0];
				var _d = global.modes.Standard.displaying_equations[| 0];
				
				//ds_list_destroy_multiple(_a, _b);
				ds_list_delete(global.modes.Standard.equations, 0);
				ds_list_delete(global.modes.Standard.displaying_equations, 0);
				ds_list_destroy_multiple(_c, _d);
				ds_list_destroy_multiple(_a, _b);
			}
	
			var _save_data = ds_map_create();
			ds_map_add_list(_save_data, global.current_mode, global.modes.Standard.displaying_equations);
			file_write_all_text("save.bin", json_encode(_save_data));
			_save_data[? global.current_mode] = -1;
			ds_map_destroy(_save_data);
			global.modes.Standard.current_equation = ds_list_create();
			global.modes.Standard.cursor_position = 0;
			
			return;
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
 * @param {Real}		_incr - The amount of change given to the position.
 * @returns {Real}	The new cursor position after navigation.
 */

function navigate_equations(_label, _pos, _pos_limit, _incr=1) {
	switch (_label) {
		case "▲":
			return clamp(_pos + _incr, 0, _pos_limit); 
		case "◀":
			return clamp(_pos - _incr, 0, _pos_limit);
		case "▼":
			return clamp(_pos - _incr, 0, _pos_limit);
		case "▶":
			return clamp(_pos + _incr, 0, _pos_limit);
	}
}