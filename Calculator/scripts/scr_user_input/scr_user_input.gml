#macro STANDARD_NAV_STEP 0.5 // Half-step for input/output switching
#macro PRACTICE_NAV_MODE_STEP -1
enum store_id_meaning {
   lhs_data = 0,
   rhs_data = 1,
   lhs_cursor_index = 2,
   rhs_cursor_index = 3,
   number_data = 0,
   number_cursor_id = 1
}

#region Subfunctions for inputing equations (or data) with buttons
function is_practice_mode_playing() {
   return obj_practice_controller.is_playing;
}

function get_practice_data() {
   var _practice = global.modes.Practice;
	
	var _current_mode_options = _practice.option_id_mapping[? _practice.practice_mode];
	var _key_array = ds_map_keys_to_array(_current_mode_options);
	array_sort(_key_array, option_compare_id);
	var _current_key = _key_array[_practice.current_option_id]

   return {
      practice: _practice,
      option_key: _current_key,
      option_data: _current_mode_options[? _current_key],
   };
}

function handle_equation_input(_key, _mode) {
   if (_mode == "Practice" and !is_practice_mode_playing()) {
      var _practice_data = get_practice_data();
      _practice_data.option_data[| store_id_meaning.number_cursor_id] = input_equation(
         _practice_data.option_data[| store_id_meaning.number_data],
         _key,
         _practice_data.option_data[| store_id_meaning.number_cursor_id]
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

function handle_normal_horizontal_navigation(_key, _mode) {
   switch (_mode) {
      case "Practice":
         if (!is_practice_mode_playing()) {
            var _practice_data = get_practice_data();
            
            _practice_data.option_data[| store_id_meaning.number_cursor_id] = navigate_equations(
               _key,
               _practice_data.option_data[| store_id_meaning.number_cursor_id],
               ds_list_size(_practice_data.option_data[| store_id_meaning.number_data]) // Length of the number
            );
         }
         break;
      
      default:
         var _current_mode = global.modes[$ global.current_mode];
         _current_mode.cursor_position = navigate_equations(
            _key,
            _current_mode.cursor_position,
            ds_list_size(_current_mode.current_equation)
         );
         break;
   }
}

function handle_standard_previous_data_horizontal_navigation(_key, _mode) {
   var _standard = global.modes.Standard;
   
   var _equations_count = ds_list_size(_standard.equations);
   var _curr_equation_id_ceil = ceil(_standard.current_equation_id);
   var _curr_equation_pos = _equations_count - _curr_equation_id_ceil;
   if (_curr_equation_id_ceil == _standard.current_equation_id) {
      _standard.equations[| _curr_equation_pos][| store_id_meaning.lhs_cursor_index] = navigate_equations(
         _key,
         _standard.equations[| _curr_equation_pos][| store_id_meaning.lhs_cursor_index],
         ds_list_size(_standard.equations[| _curr_equation_pos][| store_id_meaning.lhs_data])
      );
   } else {
      _standard.equations[| _curr_equation_pos][| store_id_meaning.rhs_cursor_index] = navigate_equations(
         _key,
         _standard.equations[| _curr_equation_pos][| store_id_meaning.rhs_cursor_index],
         ds_list_size(_standard.equations[| _curr_equation_pos][| store_id_meaning.rhs_data])
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
               ds_list_size(global.modes.Practice.option_id_mapping) - 1,
               PRACTICE_NAV_MODE_STEP
            );
         }
         break;
   }
}
#endregion

/**
 * @description This function converts the keyboard key to its equivalent button press
 * @param {String}		_mode - The room mode to be handled
 * @return {String}
 */
function convert_keyboard_key_to_button_input(_mode=global.current_mode) {
   switch (keyboard_lastkey) {
      case vk_backspace: return "⌫";
      case vk_left: return "◀";
      case vk_right: return "▶";
      case vk_down: return "▼";
      case vk_up: return "▲";
      case vk_enter: return "=";
   }
   
   switch (keyboard_lastchar) {
      case "+": return "+";
      case "-": return "−";
      case "*": return "×";
      case "/": return "÷";
   }
   
   if (array_contains([
      "=", "0", "1", "2", "3", "4",
      "5", "6", "7", "8", "9", ".",
      "(", ")"
   ], keyboard_lastchar)) {
      return keyboard_lastchar;
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
      	) { handle_normal_horizontal_navigation(_key, _mode); }
            else { handle_standard_previous_data_horizontal_navigation(_key, _mode); }
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
			//Ignore blank input.
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
         _pos = max(0, _pos - 1);
         ds_list_delete(_curr_equation, _pos);
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

function reset_invalid_input_options() {
	for (var _i = 0; _i < argument_count; _i++) {
		if (typeof(argument[_i]) == "ref" and argument[_i][| 0] == -1) {
			ds_list_clear(argument[_i]);
		}
   }
}

/**
 * @function			check_valid_praction_option
 * @description		This function checks if the input's options' parameters are correct.
 */

function check_valid_praction_option(_question_length, _min_value, _max_value, _no_dec) {
	normalize(_question_length);
	normalize(_min_value);
	normalize(_max_value);
	normalize(_no_dec);
	
	var _flag = true;
	
	if (_question_length[| 0] == -1 or _min_value[| 0] == -1 or _max_value[| 0] == -1 or _no_dec[| 0] == -1
		or compare(_min_value, _max_value) == 1
	) {
		_flag = false;
	}
	
	reset_invalid_input_options(_question_length, _min_value, _max_value, _no_dec);
	return _flag;
}