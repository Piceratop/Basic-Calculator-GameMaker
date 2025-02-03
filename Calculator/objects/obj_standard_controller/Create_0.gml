// Button creation

button_height = sprite_get_height(spr_button);
button_width = sprite_get_width(spr_button);
height_gap = 4;
width_gap = 4;
full_button_height = button_height + height_gap;
full_button_width = button_width + width_gap;
center_pos = [room_width / 2, room_height - full_button_height * 3];

button_layout = [
	["⌫", "(", ")", "÷", "▲"],
	["7", "8", "9", "×", "▼"],
	["4", "5", "6", "−", "▶"],
	["1", "2", "3", "+", "◀"],
	["0", ".", "-", "=", "Ans"]
];

create_numpad(center_pos[0], center_pos[1], button_layout, spr_button);

// Text Display

instance_create_layer(center_pos[0], center_pos[1] - 3 * full_button_height, "Button", obj_display_border);
display_padding = (room_width - 5 * full_button_width) / 2;
equations_pos = [room_width - full_button_width, center_pos[1] - 3.5 * full_button_height];
alarm[0] = game_get_speed(gamespeed_fps);

// Util function

function get_before_cursor_char_count(_eq_list, _pos) {
	var _str_pos = 0;
	for (var _i = 0; _i < _pos; _i++)
		_str_pos += string_length(global.math_decodings[? _eq_list[| _i]]);
	return _str_pos;
}

alarm[0] = game_get_speed(gamespeed_fps);