// Initialize global components
global.fnt_calculator = font_add_sprite_ext(spr_fnt_calculator, "()+-.0123456789=C×÷−⌫▲▶▼◀", true, 2);
global.border_color = c_black;
global.fnt_color = c_black;

draw_set_color(global.fnt_color);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(global.fnt_calculator);

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
global.display_text_start_pos = 1;
global.equation_max_width = room_width - button_width * 2;
global.equation_max_length = floor(global.equation_max_width / string_width("0"));
global.equations = [];
equations_pos = [room_width - button_width, center_pos[1] - 3.5 * button_width];

// Debugging
