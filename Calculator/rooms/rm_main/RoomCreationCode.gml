// Symbols mapping

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
global.math_encoding_map[? "Error"] = -1
global.math_encoding_map[? "Ans"] = -2

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

// Get saved data

global.displaying_equations = json_load("save.bin");

if (is_undefined(global.displaying_equations)) {
   global.displaying_equations = [];
}

for (
	var _i = 0, _c = 0;
	_i < array_length(global.displaying_equations) and _c < 10;
	_i++) { 
	if (string_pos("Ans", global.displaying_equations[_i][0]) != 0) {
		array_delete(global.displaying_equations, _i, 1);
		_i--;
		continue;
	} 
	_c++;
}

json_save("save.bin", global.displaying_equations);

global.equations = [];

for (
	var _i = 0; _i < array_length(global.displaying_equations); _i++) {
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

if (array_length(global.equations) > 0)
	global.Ans = global.equations[array_length(global.equations) - 1][1]
else {
	global.Ans = ds_list_create();
	ds_list_add(global.Ans, 0);
}

// Setup stores for input equations

global.current_equation = ds_list_create();
global.current_equation_id = 0;
global.cursor_position = 0;

// Font and drawing elements

global.allow_characters = "()+-.0123456789=ACEacelnorstuv|×÷⁁−⌫▲▶▼◀"
global.fnt_calculator = font_add_sprite_ext(
	spr_fnt_calculator,
	global.allow_characters,
	true, 4
);
global.back_color = c_white;
global.border_color = c_black;
global.fnt_color = c_black;

draw_set_color(global.fnt_color);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(global.fnt_calculator);

global.cursor_alpha = 1;

// Room scaling

global.rooms = [rm_main, rm_menu, rm_calculator, rm_converter];
global.base_height = 640;
global.base_width = 360;
global.rm_height = window_get_height();
//global.rm_width = global.rm_height * global.base_width / global.base_height;
global.rm_width = 360;

for (var _i = 0; _i < array_length(global.rooms); _i++) {
	layer_set_target_room(global.rooms[_i]);
	layer_background_blend(layer_background_get_id(layer_get_id("Background")), global.back_color);
}

if (room == rm_main) {
	switch(os_type) {
		case os_android:
			for (var _i = 0; _i < array_length(global.rooms); _i++) {
				room_set_height(
					global.rooms[_i], 
					global.rm_width * display_get_height() / display_get_width()
				);
			}
			break;
		case os_gxgames:
			for (var _i = 0; _i < array_length(global.rooms); _i++) {
				//room_set_height(
				//	global.rooms[_i], 
				//	global.rm_height * global.base_width / global.base_height
				//);
			}
			break;
		default:
			for (var _i = 0; _i < array_length(global.rooms); _i++) {
				room_set_height(global.rooms[_i], global.rm_height);
				room_set_width(global.rooms[_i], global.rm_width);
			}
			break;
	}
}

surface_resize(application_surface, global.rm_width, global.rm_height);

// Room navigation

room_goto(rm_menu);