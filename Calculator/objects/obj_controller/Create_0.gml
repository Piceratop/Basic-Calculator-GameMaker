// Initialize global components
global.fnt_calculator = font_add_sprite_ext(spr_fnt_calculator, "0123456789", true, 2);

// Initialize variables
button_width = 52;
center_pos = [room_width / 2, 480];
no_col = 3;
no_row = 3;

// Creating Buttons
for (var _row = 0; _row < 3; _row++) {
	for (var _col = 0; _col < 3; _col++) {
		 var _button = instance_create_layer(
			center_pos[0] + ((1 - no_row) / 2 + _row) * button_width,
			center_pos[1] + ((1 - no_col) / 2 + _col) * button_width,
			"Button",
			obj_button
		);
	}
}