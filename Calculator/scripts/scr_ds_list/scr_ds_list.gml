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