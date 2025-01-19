// Initialize global components

global.math_encoding_map = ds_map_create();
for (var _i = 0; _i < 10; _i++)
	global.math_encoding_map[? string(_i)] = _i;
global.math_encoding_map[? "."] = 10;
global.math_encoding_map[? "-"] = 11;
global.math_encoding_map[? "("] = 12;
global.math_encoding_map[? ")"] = 13;
global.math_encoding_map[? "+"] = 14;
global.math_encoding_map[? "−"] = 15;
global.math_encoding_map[? "×"] = 16;
global.math_encoding_map[? "÷"] = 17;

global.math_decoding_map = ds_map_create();
for (
	var _k = ds_map_find_first(global.math_encoding_map);
	!is_undefined(_k);
	_k = ds_map_find_next(global.math_encoding_map, _k)
) {
	var _v = global.math_encoding_map[? _k];
	global.math_decoding_map[? _v] = _k;
}

function operator(_label, _eval_function, _input_count, _position, _priority) {
	var _property_map = ds_map_create();
	_property_map[? "label"] = _label;
	_property_map[? "function"] = _eval_function;
	_property_map[? "input_count"] = _input_count;
	_property_map[? "position"] = _position;
	_property_map[? "priority"] = _priority;
	return _property_map;
}

global.operator_map = ds_map_create();
global.operator_map[? global.math_encoding_map[? "+"]] = operator("+", add, 2, "mid", 1);
global.operator_map[? global.math_encoding_map[? "−"]] = operator("−", subtract, 2, "mid", 1);
global.operator_map[? global.math_encoding_map[? "×"]] = operator("×", multiply, 2, "mid", 2);
global.operator_map[? global.math_encoding_map[? "÷"]] = operator("÷", divide, 2, "mid", 2);

global.displaying_equations = json_load("save.bin");

if (is_undefined(global.displaying_equations)) {
   global.displaying_equations = [];
}

global.equations = [];

for (var _i = 0; _i < array_length(global.displaying_equations); _i++) {
	var _curr = global.displaying_equations[_i];
	if (_curr[1] == "Error") {
		var _error_list = ds_list_create();
		ds_list_add(_error_list, -1);
		array_push(global.equations, [
			parse_equation_from_string_to_single_list(_curr[0]),
			_error_list, _curr[2], _curr[3]
		]);
	} else {
		array_push(global.equations, [
			parse_equation_from_string_to_single_list(_curr[0]),
			parse_equation_from_string_to_single_list(_curr[1]),
			_curr[2], _curr[3]
		]);
	}
}