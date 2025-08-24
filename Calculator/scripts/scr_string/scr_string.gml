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