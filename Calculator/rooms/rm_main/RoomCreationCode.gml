// Define macros
#macro TOP_DEPTH -10000

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
global.flx_numpad = flexpanel_create_node({});
global.numpad_button_height = 40;
global.numpad_gap = 4;
global.numpad_button_full_height = global.numpad_button_height + global.numpad_gap;
global.y_single_scroll = 16;

global.modes = {
	Converter: {
		convert_mode: "Length",
		conversion_rate: ds_map_create(),
		current_equation: ds_list_create(),
		converted: ds_list_create(),
		cursor_position: 0,
      flex_numpad: undefined,
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
      flx_inroom: flexpanel_create_node({ width: "100%" }),
		mode_id: -2,
		room_id: rm_setting,
	},
	Standard: {
		current_equation: ds_list_create(),
		current_equation_id: 0,
		cursor_position: 0,
		displaying_equations: ds_list_create(),
		equations: ds_list_create(),
      flex_numpad: undefined,
		mode_id: 0,
		room_id: rm_standard,
	},
	Practice: {
		current_equation: ds_list_create(),
		cursor_position: 0,
		mode_id: 2,
		option_id: 0,
		current_option_id: 0,
		option_id_mapping: ds_list_create(),
		values_of_options: ds_map_create(),
		practice_mode: "+",
		room_id: rm_practice,
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

#region The code handles saved data.
var _save_bin = file_read_all_text("save.bin");
if (not is_undefined(_save_bin)) {
	var _tmp_save = json_decode(_save_bin);
	global.modes.Standard.displaying_equations = _tmp_save[? "Standard"];
	_tmp_save[? "Standard"] = -1;		// Unallocate the list of equations.
	ds_map_destroy(_tmp_save);
}

for (var _i = 0; _i < ds_list_size(global.modes.Standard.displaying_equations); _i++) {
   var _t = global.modes.Standard.displaying_equations[| _i];
	if (string_pos("Ans", _t[| 0]) != 0 or string_pos("Error", _t[| 1]) != 0) {
		ds_list_delete(global.modes.Standard.displaying_equations, _i);
      ds_list_destroy_multiple(_t, _t);
		_i--;
	}
}

for (var _i = 0; _i < ds_list_size(global.modes.Standard.displaying_equations); _i++) {
	var _curr = global.modes.Standard.displaying_equations[| _i];
	var _eq = ds_list_create();
	ds_list_add(_eq, parse_equation_from_string_to_single_list(global.modes.Standard.displaying_equations[| _i][| 0]));
	ds_list_add(_eq, parse_equation_from_string_to_single_list(global.modes.Standard.displaying_equations[| _i][| 1]));
	ds_list_add(_eq, global.modes.Standard.displaying_equations[| _i][| 2], global.modes.Standard.displaying_equations[| _i][| 3]);
	ds_list_add(global.modes.Standard.equations, _eq);
}

global.Ans = ds_list_create();
if (ds_list_size(global.modes.Standard.equations) > 0) {
	ds_list_copy(
		global.Ans,
		global.modes.Standard.equations[| (ds_list_size(global.modes.Standard.equations) - 1)][| 1]
	);
} else { ds_list_add(global.Ans, 0); }
#endregion

#region This code handles font creation and drawing elements
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

#endregion

#region This code modifies rooms' properties.

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
global.base_width = 360;

switch(os_type) {
   case os_android:
      var _base_height = global.base_width * display_get_height() / display_get_width();
      for (var _i = 0; _i < ds_list_size(global.rooms); _i++) {
         room_set_height(
            global.rooms[| _i], _base_height
         );
      }
      surface_resize(application_surface, global.base_width, _base_height);
      break;
   default:
      var _base_height = 720;
      for (var _i = 0; _i < ds_list_size(global.rooms); _i++) {
         room_set_height(global.rooms[| _i], _base_height);
         room_set_width(global.rooms[| _i], global.base_width);
      }
      window_set_size(global.base_width, _base_height);
      surface_resize(application_surface, global.base_width, _base_height);
      break;
}

#endregion

// Navigate to the landing room

global.test_room = room;
room_goto(rm_menu);