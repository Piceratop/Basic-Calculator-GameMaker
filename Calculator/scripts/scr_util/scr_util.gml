/**
 * @function				ds_list_convert_from_array(_array)
 * @description			This function will convert an array to a ds_list
 * @params {Array}		_array - The array to be converted
 */
 
function ds_list_convert_from_array(_array) {
	var _return_list = ds_list_create();
	for (var _i = 0; _i < array_length(_array); _i++) {
		if (is_array(_array[_i])) {
			ds_list_add(_return_list, ds_list_convert_from_array(_array[_i]));
			ds_list_mark_as_list(_return_list, ds_list_size(_return_list) - 1);
		} else {
			ds_list_add(_return_list, _array[_i]);
		}
	}
	return _return_list;
}

/**
 * @function				ds_list_destroy_all(_list)
 * @description			This function will destroy the list and all of its sublist elements.
 * @param {Id.DsList}	_list - The list to be destroyed.
 */
 
function ds_list_destroy_all(_list) {
	for (var _i = 0; _i < ds_list_size(_list); _i++) {
		if (typeof(_list[| _i]) == "ref" and ds_exists(_list[| _i], ds_type_list))
			ds_list_destroy_all(_list[| _i]);
	}
	ds_list_destroy(_list);
}

/**
 * @function				ds_list_destroy_multiple()
 * @description			This function will destroy all given lists.
 */

function ds_list_destroy_multiple() {
	for (var _i = 0; _i < argument_count; _i++)
		ds_list_destroy(argument[_i]);
}

/**
 * @function				ds_list_read_all(_list)
 * @description			This function will NOT read the list and all of its sub list using the normal
								ds_list_read function.
 * @param {Id.DsList}	_return_list - The id where the list is going to be written.
 * @param {String}		_list_str - The stringified list to be read.
 */

function ds_list_read_all(_return_list, _list_str) {
	//ds_list_read(_return_list, _list_str);
	//for (var _i = 0; _i < ds_list_size(_return_list); _i++)
	//	if (typeof(_return_list[| _i] == "string"))
	//		if (string_pos("2F01", _return_list[_i]) == 0) {
	//			var _list_element = ds_list_create();
	//			if (_return_list[| _i] == "2F01000000000000") {
	//				_return_list[| _i] = _list_element;
	//			} else {
					
	//			}
	//		}
}

/**
 * @function				ds_list_write_all(_list)
 * @description			This function will write the list and all of its sub list using the normal
								ds_list_write function.
 * @param {Id.DsList}	_list - List to be written.
 */

function ds_list_write_all(_list) {
	var _list_copy = ds_list_create();
	ds_list_copy(_list_copy, _list);
	for (var _i = 0; _i < ds_list_size(_list_copy); _i++) {
		if (ds_list_is_list(_list_copy, _i)) {
			_list_copy[| _i] = ds_list_write_all(_list_copy[| _i]);
		}
	}
	var _return = ds_list_write(_list_copy);
	ds_list_destroy(_list_copy);
	return _return;
}

/**
 * @function				ds_list_reverse(_list)
 * @description			This function will reverse and reassign to the given list.
 * @param {Id.DsList}	_list - List to be reversed
 */

function ds_list_reverse(_list) {
	for (var _i = 0; _i < ds_list_size(_list) / 2; _i++) {
		var _temp = _list[| _i];
		_list[| _i] = _list[| ds_list_size(_list) - 1 - _i];
		_list[| ds_list_size(_list) - 1 - _i] = _temp;
	}
}

/**
 * @function				ds_list_stringify(_list)
 * @description			This function will represent a ds_list as a string.
 * @param {Id.DsList}	_list - The input list data structure.
 */

function ds_list_stringify(_list) {
	var _ans = "[ ";
	for (var _i = 0; _i < ds_list_size(_list); _i++) {
		if (typeof(_list[| _i]) == "ref" && ds_exists(_list[| _i], ds_type_list)) 
			_ans += ds_list_stringify(_list[| _i]);
		else _ans += string(_list[| _i]);
		if (_i != ds_list_size(_list) - 1) _ans += ", ";
	}
	_ans += " ]";
	return _ans;
}

/**
 * @function				parse_equation_from_single_list_to_string(_n)
 * @description			This function will convert a mathematical expression represented as a list 
 *								into one as a string.
 * @param {Id.DsList}	_n - The input ds_list
 */

function parse_equation_from_single_list_to_string(_n) {
	if (_n[| 0] == -1)
		return "Error";
	var _ans_str = "";
	for (var _i = 0; _i < ds_list_size(_n); _i++)
		_ans_str += global.math_decodings[? _n[| _i]];
	return _ans_str;
}

/**
 * @function				parse_equation_from_string_to_list(_eq_str)
 * @description			This function will convert a string into a mathematical expression represented 
 *								as a list.
 * @param {String}		_eq_str - The input string
 * @return {Id.DsList}
 */
 
function parse_equation_from_string_to_list(_eq_str) {
	eq_list = ds_list_create();
	eq_list_id = 0;
	curr_eq_comp = ds_list_create();
	var _refresh_curr_ep_comp = function() {
		if (ds_list_size(curr_eq_comp) > 0) {
			ds_list_add(eq_list, curr_eq_comp);
			ds_list_mark_as_list(eq_list, eq_list_id);
			eq_list_id++;
			curr_eq_comp = ds_list_create();
		}
	}
	var _is_number = true;
	for (var _i = 0; _i < string_length(_eq_str); _i++) {
		var _curr_char = string_char_at(_eq_str, _i + 1);
		var _check_is_number = (
			(ord(_curr_char) >= ord("0") and ord(_curr_char) <= ord("9")) or 
			_curr_char == "." or _curr_char == "-"
		);		
		if (_is_number xor _check_is_number == true) {
			_is_number = not _is_number;
			_refresh_curr_ep_comp();
		}
		ds_list_add(curr_eq_comp, global.math_encodings[? _curr_char]);
		if (not _is_number) {
			_refresh_curr_ep_comp();
		}
	}
	_refresh_curr_ep_comp();
	ds_list_destroy(curr_eq_comp);
	return eq_list;
}

/**
 * @function				parse_equation_from_string_to_single_list(_eq_str)
 * @description			This function will convert a string into a simple list.
 * @param {String}		_eq_str - The input string
 * @return {Id.DsList}
 */
 
function parse_equation_from_string_to_single_list(_eq_str) {
	eq_list = ds_list_create();
	for (var _i = 1; _i <= string_length(_eq_str); _i++)
		ds_list_add(eq_list, global.math_encodings[? string_char_at(_eq_str, _i)]);
	return eq_list;
}

/**
 * @function				parse_equation_from_list_to_list(_list)
 * @description			This function will convert a normal list into a mathematical expression 
 *								represented as a list.
 * @param {Id.DsList}	_list - The input list
 * @return {Id.DsList}
 */

function parse_equation_from_list_to_list(_list) {
	var _eq_list = ds_list_create();
	var _curr_eq_comp = ds_list_create();

	var _is_number = true;
	for (var _i = 0; _i < ds_list_size(_list); _i++) {
		var _curr_comp = _list[| _i];
		if (_curr_comp == -2) {
			_curr_eq_comp = _refresh_curr_eq_comp(_curr_eq_comp, _eq_list);
			ds_list_copy(_curr_eq_comp, global.Ans);
			_curr_eq_comp = _refresh_curr_eq_comp(_curr_eq_comp, _eq_list);
			continue;
		}
		if (_is_number xor _curr_comp <= global.math_encodings[? "-"]) {
			_is_number = not _is_number;
			_curr_eq_comp = _refresh_curr_eq_comp(_curr_eq_comp, _eq_list);
		}
		ds_list_add(_curr_eq_comp, _curr_comp);
		if (not _is_number)
			_curr_eq_comp = _refresh_curr_eq_comp(_curr_eq_comp, _eq_list);
	}
	_curr_eq_comp = _refresh_curr_eq_comp(_curr_eq_comp, _eq_list);
	ds_list_destroy(_curr_eq_comp);
	for (var _i = 0; _i < ds_list_size(_eq_list); _i++)
		ds_list_mark_as_list(_eq_list, _i);
	return _eq_list;
}

/**
 * @function				string_reverse(_str)
 * @description			Returns a given string with the characters in reverse order.
 * @param {string}		_str - string to be reversed
 * @return {string}    reversed string
 */

function string_reverse(_str) {
   var _out = "";
   for(var _i = string_length(_str); _i > 0; _i--) {
      _out += string_char_at(_str, _i);
   }
   return _out;
}

//////////////////// Partial Functions ///////////////////////

function evaluate_with_error_check(_number_stack, _operator_stack, _evaluating_function, _input_count) {
	var _a, _b, _c;
	switch (_input_count) {
		case 2:
			_b = ds_stack_pop(_number_stack);
			_a = ds_stack_pop(_number_stack);
			if (_a[| 0] == -1 || _b[| 0] == -1) {
				_c = ds_list_create();
				ds_list_add(_c, -1);
			} else
				_c = _evaluating_function(_a, _b);
			ds_list_destroy_multiple(_a, _b);
			if (_c[| 0] == -1)
				stack_full_remove(_number_stack, _operator_stack);
			return _c;
	}
}

function return_invalid_when_evaluating_equation(_number_stack, _operator_stack) {
	stack_full_remove(_number_stack, _operator_stack);
	var _ds_list_invalid = ds_list_create();
	ds_list_add(_ds_list_invalid, -1);
	return _ds_list_invalid;
}

function stack_full_remove(_number_stack, _operator_stack) {
	ds_stack_destroy(_operator_stack);
	while (ds_stack_size(_number_stack) > 0) {
		var _current_component = ds_stack_pop(_number_stack);
		if (typeof(_current_component) != "number")
			ds_list_destroy(_current_component);
	}
	ds_stack_destroy(_number_stack);
}

function _refresh_curr_eq_comp(_curr_eq_comp, _eq_list) {
	if (ds_list_size(_curr_eq_comp) > 0) {
		ds_list_add(_eq_list, _curr_eq_comp);
		_curr_eq_comp = ds_list_create();
	}
	return _curr_eq_comp;
}