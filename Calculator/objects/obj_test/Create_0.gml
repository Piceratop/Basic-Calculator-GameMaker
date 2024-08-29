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
	var _time = get_timer();
	for (var _k = 0; _k < 10000; _k++) {
		var _ans_list = absolute_value(_test_list);
		ds_list_destroy(_ans_list);
	}
	show_debug_message(get_timer() - _time);
	var _ans_list = absolute_value(_test_list);
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
	var _time = get_timer();
	for (var _k = 0; _k < 10000; _k++) {
		var _ans_list = inverse(_test_list);
		ds_list_destroy(_ans_list);
	}
	show_debug_message(get_timer() - _time);
	var _ans_list = inverse(_test_list);
	print_ds_list(_ans_list);
	ds_list_destroy(_test_list);
	ds_list_destroy(_ans_list);
}
show_debug_message("");

// Shift Decimal
show_debug_message("Shift Decimal");
test_cases_2 = [
	[[1, 2, 10, 3, 4], 0],
	[[1, 2, 10, 3, 4], -1],
	[[1, 2, 10, 3, 4], 1],
	[[1, 2, 10, 3, 4], -2],
	[[1, 2, 10, 3, 4], 2],
	[[1, 2, 10, 3, 4], -3],
	[[1, 2, 10, 3, 4], 3],
]
for (var _i = 0; _i < array_length(test_cases_2); _i++) {
	var _test_list = ds_list_create();
	for (var _j = 0; _j < array_length(test_cases_2[_i][0]); _j++)
		ds_list_add(_test_list, test_cases_2[_i][0][_j]);
	var _time = get_timer();
	for (var _k = 0; _k < 10000; _k++) {
		var _ans_list = shift_decimal(_test_list, test_cases_2[_i][1]);
		ds_list_destroy(_ans_list);
	}
	show_debug_message(get_timer() - _time);
	var _ans_list = shift_decimal(_test_list, test_cases_2[_i][1]);
	print_ds_list(_ans_list);
	ds_list_destroy(_test_list);
	ds_list_destroy(_ans_list);
}
show_debug_message("");

// Compare
show_debug_message("Compare");
test_cases_3 = [
	[[1], [1]],
	[[1], [2]],
	[[2], [1]],
	[[0], [11, 0]],
	[[1], [11, 0]],
	[[11, 1], [11, 2]],
	[[11, 0], [11, 1]],
	[[1, 4, 7, 8], [1, 3, 4, 5, 6]],
	[[11, 1, 0, 10, 2], [11, 1, 0, 10, 2]],
	[[11, 6, 3, 9, 1, 9, 2], [11, 8, 4, 3, 0, 5, 4]],
	[[1, 10, 2, 4, 6, 8, 9], [1, 10, 7, 5, 3, 1, 1]],
	[[1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9]],
	[[11, 1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9]],
	[[1, 2, 3, 4, 5, 6, 7, 8, 9], [11, 1, 2, 3, 4, 5, 6, 7, 8, 9]],
	[[1, 2, 3, 4, 5, 6, 10, 4, 5], [1, 2, 3, 10, 4, 5, 6, 7, 8, 9, 1, 2, 3]],
]
for (var _i = 0; _i < array_length(test_cases_3); _i++) {
	var _test_list_0 = ds_list_create();
	var _test_list_1 = ds_list_create();
	for (var _j = 0; _j < array_length(test_cases_3[_i][0]); _j++) {
		ds_list_add(_test_list_0, test_cases_3[_i][0][_j]);	
	}
	for (var _j = 0; _j < array_length(test_cases_3[_i][1]); _j++) {
		ds_list_add(_test_list_1, test_cases_3[_i][1][_j]);	
	}
	var _time = get_timer();
	for (var _k = 0; _k < 10000; _k++) {
		var _ans = compare(_test_list_0, _test_list_1);
	}
	show_debug_message(get_timer() - _time);
	var _ans = compare(_test_list_0, _test_list_1);
	show_debug_message(_ans);
	ds_list_destroy(_test_list_0);
	ds_list_destroy(_test_list_1);
}
show_debug_message("");

// Add
show_debug_message("Add");
for (var _i = 0; _i < array_length(test_cases_3); _i++) {
	var _test_list_0 = ds_list_create();
	var _test_list_1 = ds_list_create();
	for (var _j = 0; _j < array_length(test_cases_3[_i][0]); _j++) {
		ds_list_add(_test_list_0, test_cases_3[_i][0][_j]);	
	}
	for (var _j = 0; _j < array_length(test_cases_3[_i][1]); _j++) {
		ds_list_add(_test_list_1, test_cases_3[_i][1][_j]);	
	}
	var _time = get_timer();
	for (var _k = 0; _k < 10000; _k++) {
		var _ans_list = add(_test_list_0, _test_list_1);
		ds_list_destroy(_ans_list);
	}
	show_debug_message(get_timer() - _time);
	var _ans_list = add(_test_list_0, _test_list_1);
	print_ds_list(_ans_list);
	ds_list_destroy(_test_list_0);
	ds_list_destroy(_test_list_1);
	ds_list_destroy(_ans_list);
}
show_debug_message("");

// Subtract
show_debug_message("Subtract");
for (var _i = 0; _i < array_length(test_cases_3); _i++) {
	var _test_list_0 = ds_list_create();
	var _test_list_1 = ds_list_create();
	for (var _j = 0; _j < array_length(test_cases_3[_i][0]); _j++) {
		ds_list_add(_test_list_0, test_cases_3[_i][0][_j]);	
	}
	for (var _j = 0; _j < array_length(test_cases_3[_i][1]); _j++) {
		ds_list_add(_test_list_1, test_cases_3[_i][1][_j]);	
	}
	var _time = get_timer();
	for (var _k = 0; _k < 10000; _k++) {
		var _ans_list = subtract(_test_list_0, _test_list_1);
		ds_list_destroy(_ans_list);
	}
	show_debug_message(get_timer() - _time);
	var _ans_list = subtract(_test_list_0, _test_list_1);
	print_ds_list(_ans_list);
	ds_list_destroy(_test_list_0);
	ds_list_destroy(_test_list_1);
	ds_list_destroy(_ans_list);
}
show_debug_message("");