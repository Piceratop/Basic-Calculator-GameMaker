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

// rm_main initial function

function single_option_add_data(_option, _key, _id) {
	/* 
    * Adding a list with two elements to the values_of_options map for recording
    * The first one is the value of the option
    * The second one is the cursor position of the option
	 * The third one is the id of the option.
    */
	
	var _l = ds_list_create();
	var _data = ds_list_create();
	ds_list_add(_l, _data);
	ds_list_mark_as_list(_l, 0);
	ds_list_add(_l, 0);
	ds_list_add(_l, _id);
	ds_map_add_list(_option, _key, _l);
}

function option_id_mapping_add_options(_value, _option_id_mapping) {
	var _list_options = ds_map_create();
	switch (_value) {
		case "+":
		case "+−":
			single_option_add_data(_list_options, "Question's length", 0);
			single_option_add_data(_list_options, "Minimum", 1);
			single_option_add_data(_list_options, "Maximum", 2);
			single_option_add_data(_list_options, "No. decimal places", 3);
			break;
	}
	
	ds_map_add_map(_option_id_mapping, _value, _list_options);
}

// obj_practice_controller partial function
function option_compare_id(_key_1, _key_2) {
	var _current_mode_options = global.modes.Practice.option_id_mapping[? global.modes.Practice.practice_mode];
	return _current_mode_options[? _key_1][| global.store_pos_practice_option_id] - _current_mode_options[? _key_2][| global.store_pos_practice_option_id];
}