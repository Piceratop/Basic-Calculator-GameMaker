/*
 * @function				ds_list_destroy_multiple()
 * @description			This function will destroy all given lists.
 * @return {undefined}
 */
function ds_list_destroy_multiple() {
	for (var _i = 0; _i < argument_count; _i++)
		ds_list_destroy(argument[_i]);
}

/*
 * @function				ds_list_reverse(_list)
 * @description			This function will reverse and reassign to the given list.
 * @param {Id.DsList}	_list - List to be reversed
 * @return {undefined}
 */

function ds_list_reverse(_list) {
	for (var _i = 0; _i < ds_list_size(_list) / 2; _i++) {
		var _temp = _list[| _i];
		_list[| _i] = _list[| ds_list_size(_list) - 1 - _i];
		_list[| ds_list_size(_list) - 1 - _i] = _temp;
	}
}

/*
 * @function				parse_equation()
 * @description			This function will convert a string into a 
 *								mathematical expression represented by a list.
 * @param {String}		_eq_str - The input string
 * @return {Id.DsList}
 */
 
function parse_equation(_eq_str) {
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
		ds_list_add(curr_eq_comp, global._math_encoding_map[? _curr_char]);
		if (not _is_number) {
			_refresh_curr_ep_comp();
		}
	}
	_refresh_curr_ep_comp();
	ds_list_destroy(curr_eq_comp);
	return eq_list;
}

/// @function				stringify_ds_list(_str)
/// @description			This function will represent a ds_list as a string.
/// @param {Id.DsList}	_list - The input list data structure.
/// @return {String}

function stringify_ds_list(_list) {
	var _ans = "[ ";
	for (var _i = 0; _i < ds_list_size(_list); _i++) {
		if (ds_list_is_list(_list, _i)) {
			_ans += stringify_ds_list(_list[| _i]);
		} else {
			_ans += string(_list[| _i]);
			if (_i != ds_list_size(_list) - 1) _ans += ", ";
		}
	}
	_ans += " ]";
	return _ans;
}

/*
 * @function				string_reverse(_str)
 * @description			Returns a given string with the characters in reverse order.
 * @param {string}		_str - string to be reversed
 * @return {string}    reversed string
 */

function string_reverse(_str) {
   var _out = "";
   for(var _i = string_length(_str); _i>0; _i--) {
      _out += string_char_at(_str, _i);
   }
   return _out;
}
