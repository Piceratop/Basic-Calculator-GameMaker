// Initialize global components
global.allow_characters = "()+-.0123456789=CEor|×÷⁁−⌫▲▶▼◀"
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

global.equations = [];

// Initialize variables
button_width = 52;
center_pos = [room_width / 2, room_height - 168];

// Creating Buttons
global.button_layout = [
	["⌫", "(", ")", "÷", "▲"],
	["7", "8", "9", "×", "▼"],
	["4", "5", "6", "−", "▶"],
	["1", "2", "3", "+", "◀"],
	["0", ".", "-", "=", ""]
];
no_col = array_length(global.button_layout);
no_row = array_length(global.button_layout[0]);
for (var _row = 0; _row < no_row; _row++) {
	for (var _col = 0; _col < no_col; _col++) {
		 var _button = instance_create_layer(
			center_pos[0] + ((1 - no_row) / 2 + _row) * button_width,
			center_pos[1] + ((1 - no_col) / 2 + _col) * button_width,
			"Button",
			obj_button,
			{
				pos_x: _row,
				pos_y: _col,
				label: global.button_layout[_col][_row] 
			}
		);
	}
}

// Text Display
instance_create_layer(center_pos[0], center_pos[1] - 3 * button_width, "Button", obj_display_border);
global.current_equation = "";
global.cursor_position = 1;
global.equation_max_width = room_width - button_width * 2;
cursor_alpha = 0;
display_padding = button_width;
equations_pos = [room_width - button_width, center_pos[1] - 3.5 * button_width];
alarm[0] = game_get_speed(gamespeed_fps);

// Debugging
