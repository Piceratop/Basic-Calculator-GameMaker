// ========= Numpad =========

// Button creation

full_button_height = 44;

button_layout = [
	["⌫", "◀", "▶"],
	["7", "8", "9"],
	["4", "5", "6"],
	["1", "2", "3"],
	["=", "0", "."],
];
alarm[0] = game_get_speed(gamespeed_fps);

create_numpad(room_width / 2, room_height - 3 * full_button_height, button_layout, 100, 40, 4);

// ========= Dropdown and IO Displays =========

var _display_top_position = room_width / 4;
var _box_width = 288;
box_height = 48;

var _sb_width = sprite_get_width(spr_scroll_button) / 2;
var _margin = (room_width - _box_width) / 2;

// Display of input unit
input_unit_dropdown = dropdown_create(
	room_width / 2, _display_top_position, "Button", "input",
	_box_width, box_height, global.modes.Converter.dropdown_options
);
with (input_unit_dropdown) 
	global.modes.Converter.input_unit = options[| current_option_id];
instance_create_layer(
	room_width / 2,
	_display_top_position + box_height + 8,
	"Button",
	obj_converter_box, 
	{
		image_xscale: _box_width / sprite_get_width(spr_box_center),
		image_yscale: box_height / sprite_get_height(spr_box_center),
		name: "input",
	}
);

// Display of output unit
output_unit_dropdown = dropdown_create(
	room_width / 2, _display_top_position + 3 * box_height, "Button", "output", 
	_box_width, box_height, global.modes.Converter.dropdown_options
);
with (output_unit_dropdown) 
	global.modes.Converter.output_unit = options[| current_option_id];
instance_create_layer(
	room_width / 2,
	_display_top_position + 4 * box_height + 8,
	"Button",
	obj_converter_box, 
	{
		image_xscale: _box_width / sprite_get_width(spr_box_center),
		image_yscale: box_height / sprite_get_height(spr_box_center),
		name: "output",
	}
);

// Dropdown Handling

current_dropdown = noone;