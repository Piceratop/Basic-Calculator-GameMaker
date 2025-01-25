// Initialize variables
button_height = sprite_get_height(spr_button);
button_width = sprite_get_width(spr_button);
height_gap = 4;
width_gap = 4;
full_button_height = button_height + height_gap;
full_button_width = button_width + width_gap;
center_pos = [room_width / 2, room_height - full_button_height * 3];

// Creating Buttons
global.button_layout = [
	["⌫", "(", ")", "÷", "▲"],
	["7", "8", "9", "×", "▼"],
	["4", "5", "6", "−", "▶"],
	["1", "2", "3", "+", "◀"],
	["0", ".", "-", "=", "Ans"]
];
no_col = array_length(global.button_layout);
no_row = array_length(global.button_layout[0]);
for (var _row = 0; _row < no_row; _row++) {
	for (var _col = 0; _col < no_col; _col++) {
		 var _button = instance_create_layer(
			center_pos[0] + ((1 - no_row) / 2 + _row) * full_button_width,
			center_pos[1] + ((1 - no_col) / 2 + _col) * full_button_height,
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
instance_create_layer(center_pos[0], center_pos[1] - 3 * full_button_height, "Button", obj_display_border);
global.current_equation = ds_list_create();
global.current_equation_id = 0;
global.cursor_position = 0;
cursor_alpha = 0;
display_padding = (room_width - 5 * full_button_width) / 2;
equations_pos = [room_width - full_button_width, center_pos[1] - 3.5 * full_button_height];
alarm[0] = game_get_speed(gamespeed_fps);

// Debugging
