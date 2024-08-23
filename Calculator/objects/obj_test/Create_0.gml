/// @description Measuring Built-in Functions

// array_length

show_debug_message("array_length");
arr1 = [0];
arr2 = [];
for (var _i = 0; _i < 10000; _i++) 
	array_push(arr2, 0);
time = get_timer();
for (var _i = 0; _i < 10000; _i++)
	a = array_length(arr1);
show_debug_message(get_timer() - time);
time = get_timer();
for (var _i = 0; _i < 10000; _i++)
	a = array_length(arr2);
show_debug_message($"{get_timer() - time}\n");

// array_shift vs array_delete

show_debug_message("array_shift vs array_delete");
time = get_timer();
for (var _i = 0; _i < 10000; _i++) {
	arr1 = [11, 11, 1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 6, 7, 8, 9];
	array_shift(arr1);
	array_shift(arr1);
}
show_debug_message(get_timer() - time);
time = get_timer();
for (var _i = 0; _i < 10000; _i++) {
	arr1 = [11, 11, 1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 6, 7, 8, 9];
	array_delete(arr1, 0, 2);
}
show_debug_message($"{get_timer() - time}\n");

/// @description Testing custom written functions

// Get Decimal Position
test_cases = [
	[0, 10, 5, 7, 8, 6, 4],
	[9, 5, 10],
	[1, 2, 3, 4, 4, 3, 2, 1],
	[9, 5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1]
]
check_function_multi_cases(get_decimal_position, test_cases);

// Normalize
test_cases = [
	[0, 0, 0, 0, 0, 10, 5, 7, 8, 6],
	[9, 5, 10, 0, 0, 0, 0, 0],
	[0],
	[0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0],
	[11, 11, 11, 9, 8, 10, 2],
	[11, 11, 11, 11, 9, 8, 10, 2],
	[11, 11, 11, 0, 0, 0, 0, 9, 8, 10, 2]
]
check_function_multi_cases(normalize, test_cases);

// Absolute Value
test_cases = [
	[11, 0, 1],
	[3, 5, 10, 1],
	[11, 11, 11, 9, 8, 10, 2],
	[11, 11, 11, 11, 9, 8, 10, 2]
];
check_function_multi_cases(absolute_value, test_cases);

// Inverse
test_cases = [
	[11, 0, 1],
	[3, 5, 10, 1],
	[11, 11, 11, 9, 8, 10, 2],
	[11, 11, 11, 11, 9, 8, 10, 2]
];
check_function_multi_cases(inverse, test_cases);