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

// Main display

var _display_top_position = room_width / 4;
var _box_width = 288;
var _box_height = 48;
var _margin = (room_width - _box_width) / 2;
var _dropdown_style = {
	image_xscale: _box_width / sprite_get_width(spr_border),
	margin: _margin
};

instance_create_layer(
	room_width / 2, 
	_display_top_position,
	"Button",
	obj_dropdown, 
	_dropdown_style
);

instance_create_layer(
	room_width / 2,
	_display_top_position + _box_height + 8,
	"Button",
	obj_converter_box, 
	{
		image_xscale: _box_width / sprite_get_width(spr_box),
		image_yscale: _box_height / sprite_get_height(spr_box)
	}
);

instance_create_layer(
	room_width / 2, 
	_display_top_position + 3 * _box_height,
	"Button",
	obj_dropdown, 
	_dropdown_style
);
