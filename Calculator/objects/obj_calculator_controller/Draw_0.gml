draw_set_valign(fa_bottom);
draw_set_color(global.fnt_color);
var _bottom_position = center_pos[1] - 3.5 * button_width;

// Display the past equations

for (var _i = array_length(global.equations) - 1; _i >= 0; _i--) {
	draw_enclosed_text(
		0, room_width,
		_bottom_position - 2 * (array_length(global.equations) - _i) * string_height("1"),
		display_padding,
		global.equations[_i][0], global.equations[_i][2],
		real(array_length(global.equations) - _i  == global.current_equation_id) * cursor_alpha
	);
	draw_enclosed_text(
		0, room_width,
		_bottom_position - (2 * (array_length(global.equations) - _i) - 1) * string_height("1"),
		display_padding,
		global.equations[_i][1], global.equations[_i][3],
		real(array_length(global.equations) - _i - 0.5 == global.current_equation_id) * cursor_alpha
	);
}

// Display the equation that the user is typing
draw_enclosed_text(
	0, room_width, _bottom_position, display_padding, 
	parse_equation_from_single_list_to_string(global.current_equation),
	global.cursor_position, 
	real(global.current_equation_id == 0) * cursor_alpha
);

// Show debug message on screen

