// Normalize
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
test_normalize = function () {
	show_debug_message("Normalize");
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
}


// Absolute Value
test_absolute_value = function () {
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
		self_absolute_value(_test_list);
		print_ds_list(_ans_list);
		print_ds_list(_test_list);
		ds_list_destroy(_test_list);
		ds_list_destroy(_ans_list);
	}
	show_debug_message("");
}
//test_absolute_value();

// Inverse
test_inverse = function () {
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
		self_inverse(_test_list);
		print_ds_list(_ans_list);
		print_ds_list(_test_list);
		ds_list_destroy(_test_list);
		ds_list_destroy(_ans_list);
	}
	show_debug_message("");
}
//test_inverse();

// Shift Decimal
test_cases_2 = [
	[[1, 2, 10, 3, 4], 0],
	[[1, 2, 10, 3, 4], -1],
	[[1, 2, 10, 3, 4], 1],
	[[1, 2, 10, 3, 4], -2],
	[[1, 2, 10, 3, 4], 2],
	[[1, 2, 10, 3, 4], -3],
	[[1, 2, 10, 3, 4], 3],
]
test_shift_decimal = function () {
	show_debug_message("Shift Decimal");
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
		self_shift_decimal(_test_list, test_cases_2[_i][1]);
		print_ds_list(_ans_list);
		print_ds_list(_test_list);
		ds_list_destroy(_test_list);
		ds_list_destroy(_ans_list);
	}
	show_debug_message("");
}
//test_shift_decimal();

// Compare
test_cases_3 = [
	[[1], [1]],
	[[1], [2]],
	[[2], [1]],
	[[2, 3, 5], [8, 0, 0]],
	[[1, 4, 7, 8], [1, 3, 4, 5, 6]],
	[[2, 4, 9, 6, 6, 2, 7, 3], [6, 3, 7, 0, 6, 5, 0, 9]],
	[[1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9]],
	[[1, 2, 3, 4, 5, 6, 10, 4, 5], [1, 2, 3, 10, 4, 5, 6, 7, 8, 9, 1, 2, 3]],
	[[1, 1, 1, 1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1]],
	[[0], [11, 0]],
	[[1], [11, 0]],
	[[11, 1], [11, 2]],
	[[11, 0], [11, 1]],
	[[11, 1, 0, 10, 2], [11, 1, 0, 10, 2]],
	[[11, 6, 3, 9, 1, 9, 2], [11, 8, 4, 3, 0, 5, 4]],
	[[1, 10, 2, 4, 6, 8, 9], [1, 10, 7, 5, 3, 1, 1]],
	[[11, 1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9]],
	[[1, 2, 3, 4, 5, 6, 7, 8, 9], [11, 1, 2, 3, 4, 5, 6, 7, 8, 9]],
]
test_compare = function () {
	show_debug_message("Compare");
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
}

// Add
test_add = function () {
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
}
//test_add();

// Subtract
test_subtract = function() {
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
}

// Multiply (Integer)
test_cases_4 = [
	[[2], [3]],
	[[1, 2, 3], [4]],
	[[4], [1, 2, 3]],
	[[2, 3], [4, 5]],
	[[5, 7, 9], [5, 9, 9]],
	[[6, 0, 0], [5, 3, 5, 4]],
	[[5, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9], [1, 2]],
	[[1, 2, 3, 4, 5, 6, 7, 8, 9], [2, 4, 6, 8, 9, 1, 3, 5, 7]],
	[[6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],
	[[9, 9, 8, 8, 7, 7, 6, 6, 5, 5, 4, 4, 3, 3, 2, 2, 1, 1], [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9]],
]
test_multiply_integer = function () {
	show_debug_message("Multiply (Integer)");
	for (var _i = 0; _i < array_length(test_cases_4); _i++) {
		var _test_list_0 = ds_list_create();
		var _test_list_1 = ds_list_create();
		for (var _j = 0; _j < array_length(test_cases_4[_i][0]); _j++) {
			ds_list_add(_test_list_0, test_cases_4[_i][0][_j]);	
		}
		for (var _j = 0; _j < array_length(test_cases_4[_i][1]); _j++) {
			ds_list_add(_test_list_1, test_cases_4[_i][1][_j]);	
		}
		var _time = get_timer();
		for (var _k = 0; _k < 1000; _k++) {
			var _ans_list = int_multiply_v1(_test_list_0, _test_list_1);
			ds_list_destroy(_ans_list);
		}
		show_debug_message(get_timer() - _time);
		_time = get_timer();
		for (var _k = 0; _k < 1000; _k++) {
			var _ans_list = int_multiply_v2(_test_list_0, _test_list_1);
			ds_list_destroy(_ans_list);
		}
		show_debug_message(get_timer() - _time);
		var _ans_list = int_multiply_v1(_test_list_0, _test_list_1);
		print_ds_list(_ans_list);
		ds_list_destroy(_ans_list);
		_ans_list = int_multiply_v2(_test_list_0, _test_list_1);
		print_ds_list(_ans_list);
		ds_list_destroy(_ans_list);
		ds_list_destroy(_test_list_0);
		ds_list_destroy(_test_list_1);
	}
	show_debug_message("");
}
//test_multiply_integer();

// Multiply
test_multiply = function() {
	show_debug_message("Multiply");
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
			var _ans_list = multiply(_test_list_0, _test_list_1);
			ds_list_destroy(_ans_list);
		}
		show_debug_message(get_timer() - _time);
		var _ans_list = multiply(_test_list_0, _test_list_1);
		print_ds_list(_ans_list);
		ds_list_destroy(_test_list_0);
		ds_list_destroy(_test_list_1);
		ds_list_destroy(_ans_list);
	}
	show_debug_message("");
}
//test_multiply();

// Division (Integer)
test_cases_5 = [
	[[6], [3]],
	[[1, 2], [4]],
	[[5, 7], [1, 9]],
	[[5, 7, 0, 0, 0, 0], [1, 9, 0]],
]
test_divide_integer = function () {
	show_debug_message("Division (Integer)");
	for (var _i = 0; _i < array_length(test_cases_5); _i++) {
		var _test_list_0 = ds_list_create();
		var _test_list_1 = ds_list_create();
		for (var _j = 0; _j < array_length(test_cases_5[_i][0]); _j++) {
			ds_list_add(_test_list_0, test_cases_5[_i][0][_j]);	
		}
		for (var _j = 0; _j < array_length(test_cases_5[_i][1]); _j++) {
			ds_list_add(_test_list_1, test_cases_5[_i][1][_j]);	
		}
		//var _time = get_timer();
		//for (var _k = 0; _k < 1000; _k++) {
		//	var _ans_list = int_multiply_v1(_test_list_0, _test_list_1);
		//	ds_list_destroy(_ans_list);
		//}
		//show_debug_message(get_timer() - _time);
		var _ans_list = int_divide_v1(_test_list_0, _test_list_1, 6);
		print_ds_list(_ans_list);
		ds_list_destroy(_ans_list);
		ds_list_destroy(_test_list_0);
		ds_list_destroy(_test_list_1);
	}
	show_debug_message("");
}
test_divide_integer();