// Normalize
show_debug_message("Normalize");
test_cases = [
	[0, 0, 0, 0, 0, 10, 5, 7, 8, 6],
	[9, 5, 10, 0, 0, 0, 0, 0],
	[0],
	[0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0],
	[11, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0],
	[11, 11, 11, 9, 8, 10, 2],
	[11, 11, 11, 11, 9, 8, 10, 2],
	[11, 11, 11, 0, 0, 0, 0, 9, 8, 10, 2],
	[0, 0, 0, 0, 0, 0, 0, 0, 10, 2],
	[11, 0, 0, 0, 0, 0, 0, 0, 0, 10, 2],
	[11, 11, 11, 11, 0, 0, 0, 0, 0, 0, 0, 0, 9, 8, 10, 1, 2, 3, 4, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 7, 8, 9, 1, 2, 3, 4, 5, 7, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0,],
]
for (var _i = 0; _i < array_length(test_cases); _i++) {
	var _test_list = ds_list_create();
	for (var _j = 0; _j < array_length(test_cases[_i]); _j++)
		ds_list_add(_test_list, test_cases[_i, _j]);
	var _time = get_timer();
	normalize(_test_list);
	show_debug_message(get_timer() - _time);
	print_ds_list(_test_list);
	ds_list_destroy(_test_list);
}
show_debug_message("");

// Absolute Value
show_debug_message("Absolute Value");
for (var _i = 0; _i < array_length(test_cases); _i++) {
	var _test_list = ds_list_create();
	for (var _j = 0; _j < array_length(test_cases[_i]); _j++)
		ds_list_add(_test_list, test_cases[_i, _j]);
	var _ans_list = ds_list_create();
	_ans_list = absolute_value(_test_list);
	var _time = get_timer();
	show_debug_message(get_timer() - _time);
	print_ds_list(_ans_list);
	ds_list_destroy(_test_list);
	ds_list_destroy(_ans_list);
}
show_debug_message("");

// Inverse
show_debug_message("Inverse");
for (var _i = 0; _i < array_length(test_cases); _i++) {
	var _test_list = ds_list_create();
	for (var _j = 0; _j < array_length(test_cases[_i]); _j++)
		ds_list_add(_test_list, test_cases[_i, _j]);
	var _ans_list = ds_list_create();
	_ans_list = inverse(_test_list);
	var _time = get_timer();
	show_debug_message(get_timer() - _time);
	print_ds_list(_ans_list);
	ds_list_destroy(_test_list);
	ds_list_destroy(_ans_list);
}
show_debug_message("");

// Shift Decimal
//test_cases = [
//	[[1, 2, 10, 3, 4], -1],
//	[[1, 2, 10, 3, 4], 1]
//]
//check_function_multi_cases(shift_decimal, test_cases, 2);
