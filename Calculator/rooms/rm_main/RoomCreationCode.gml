// Symbols mapping

global.math_encodings = ds_map_create();
for (var _i = 0; _i < 10; _i++)
	global.math_encodings[? string(_i)] = _i;
global.math_encodings[? "."] = 10;
global.math_encodings[? "-"] = 11;
global.math_encodings[? "("] = 12;
global.math_encodings[? ")"] = 13;
global.math_encodings[? "+"] = 14;
global.math_encodings[? "−"] = 15;
global.math_encodings[? "×"] = 16;
global.math_encodings[? "÷"] = 17;
global.math_encodings[? "Error"] = -1;
global.math_encodings[? "Ans"] = -2

global.math_decodings = ds_map_create();

for (
	var _k = ds_map_find_first(global.math_encodings);
	!is_undefined(_k);
	_k = ds_map_find_next(global.math_encodings, _k)
) {
	global.math_decodings[? global.math_encodings[? _k]] = _k;
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
global.operator_map[? global.math_encodings[? "+"]] = operator("+", add, 2, "mid", 1);
global.operator_map[? global.math_encodings[? "−"]] = operator("−", subtract, 2, "mid", 1);
global.operator_map[? global.math_encodings[? "×"]] = operator("×", multiply, 2, "mid", 2);
global.operator_map[? global.math_encodings[? "÷"]] = operator("÷", divide, 2, "mid", 2);

global.unit_name = ds_map_create();
global.unit_name[? "cm"] = "Centimeter";
global.unit_name[? "ft"] = "Foot/Feet";
global.unit_name[? "grain"] = "Grain";
global.unit_name[? "km"] = "Kilometer";
global.unit_name[? "kg"] = "Kilogram";
global.unit_name[? "m"] = "Meter";
global.unit_name[? "mi"] = "Mile";
global.unit_name[? "mm"] = "Milimeter";
global.unit_name[? "t"] = "Metric Ton";

// Initialize shared datas

global.current_dropdown = noone;
global.current_mode = "Menu";
global.current_object = noone;
global.numpad_button_height = 40;
global.numpad_gap = 4;
global.numpad_button_full_height = global.numpad_button_height + global.numpad_gap;

global.modes = {
	Converter: {
		convert_mode: "Length",
		conversion_rate: ds_map_create(),
		current_equation: ds_list_create(),
		converted: ds_list_create(),
		cursor_position: 0,
		input_unit: "m",
		output_unit: "m",
		mode_id: 1,
		room_id: rm_converter,
	},
	Menu: {
		mode_id: -1,
		room_id: rm_menu,
	},
	Setting: {
		mode_id: -2,
		room_id: rm_setting,
	},
	Standard: {
		current_equation: ds_list_create(),
		current_equation_id: 0,
		cursor_position: 0,
		displaying_equations: json_load("save.bin"),
		equations: [],
		mode_id: 0,
		room_id: rm_standard,
	},
	Practice: {
		current_equation: ds_list_create(),
		cursor_position: 0,
		mode_id: 2,
		option_id: 0,
		option_id_mapping: ds_list_create(),
		practice_mode: "+",
		room_id: rm_practice
	}
}

// Conversion rates input

global.modes.Converter.conversion_rate[? "Length"] = ds_map_create();
var _lcr = global.modes.Converter.conversion_rate[? "Length"];
_lcr[? "cm"] = parse_equation_from_string_to_single_list("0.01");
_lcr[? "ft"] = parse_equation_from_string_to_single_list("0.3048");
_lcr[? "km"] = parse_equation_from_string_to_single_list("1000");
_lcr[? "m"] = parse_equation_from_string_to_single_list("1");
_lcr[? "mi"] = parse_equation_from_string_to_single_list("1609.344");
_lcr[? "mm"] = parse_equation_from_string_to_single_list("0.001");
global.modes.Converter.conversion_rate[? "Mass"] = ds_map_create();
var _mcr = global.modes.Converter.conversion_rate[? "Mass"]
_mcr[? "grain"] = parse_equation_from_string_to_single_list("0.0000648");
_mcr[? "kg"] = parse_equation_from_string_to_single_list("1");
_mcr[? "t"] = parse_equation_from_string_to_single_list("1000");

// Get saved data

if (is_undefined(global.modes.Standard.displaying_equations)) {
   global.modes.Standard.displaying_equations = [];
}

for (
	var _i = 0, _c = 0;
	_i < array_length(global.modes.Standard.displaying_equations) and _c < 10;
	_i++
) { 
	if (string_pos("Ans", global.modes.Standard.displaying_equations[_i][0]) != 0
	or string_pos("Error", global.modes.Standard.displaying_equations[_i][1]) != 0) {
		array_delete(global.modes.Standard.displaying_equations, _i, 1);
		_i--;
	} else _c++;
}

json_save("save.bin", global.modes.Standard.displaying_equations);

for (
	var _i = 0; _i < array_length(global.modes.Standard.displaying_equations); _i++) {
	var _curr = global.modes.Standard.displaying_equations[_i];
	if (_curr[1] == "Error") {
		var _error_list = ds_list_create();
		ds_list_add(_error_list, -1);
		array_push(global.modes.Standard.equations, [
			parse_equation_from_string_to_single_list(_curr[0]),
			_error_list, _curr[2], _curr[3]
		]);
	} else {
		array_push(global.modes.Standard.equations, [
			parse_equation_from_string_to_single_list(_curr[0]),
			parse_equation_from_string_to_single_list(_curr[1]),
			_curr[2], _curr[3]
		]);
	}
}

global.Ans = ds_list_create();
if (array_length(global.modes.Standard.equations) > 0)
	ds_list_copy(
		global.Ans,
		global.modes.Standard.equations[array_length(global.modes.Standard.equations) - 1][1]
	);
else	
	ds_list_add(global.Ans, 0);


// Font and drawing elements

global.allow_characters = 
	" &'()+-./0123456789:=" +
	"ACEFGKLMSTPQ" + 
	"abcdefghiklmnoprstuvxy" + 
	"|×÷⁁−⌫▲▶▼◀";
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

// Changing the color of rooms
global.rooms = ds_list_create();
ds_list_add(global.rooms, rm_main);

var _tmp_keys = variable_struct_get_names(global.modes);
for (var _i = 0; _i < array_length(_tmp_keys); _i++) {
	ds_list_add(global.rooms, global.modes[$ _tmp_keys[_i]].room_id);
}

for (var _i = 0; _i < ds_list_size(global.rooms); _i++) {
	layer_set_target_room(global.rooms[| _i]);
	layer_background_blend(layer_background_get_id(layer_get_id("Background")), global.back_color);
}

// Room scaling
global.base_height = 640;
global.base_width = 360;
global.rm_height = window_get_height();
//global.rm_width = global.rm_height * global.base_width / global.base_height;
global.rm_width = 360;

if (room == rm_main) {
	switch(os_type) {
		case os_android:
			for (var _i = 0; _i < ds_list_size(global.rooms); _i++) {
				room_set_height(
					global.rooms[| _i], 
					global.rm_width * display_get_height() / display_get_width()
				);
			}
			break;
		default:
			for (var _i = 0; _i < ds_list_size(global.rooms); _i++) {
				room_set_height(global.rooms[| _i], global.rm_height);
				room_set_width(global.rooms[| _i], global.rm_width);
			}
			break;
	}
}

surface_resize(application_surface, global.rm_width, global.rm_height);

// Navigate to the landing room

//ds_list_destroy(global.rooms); // Cleaning if needed
room_goto(rm_menu);