draw_set_valign(fa_bottom);
draw_set_color(global.fnt_color);

// Display past equations

for (var _i = array_length(global.equations) - 1; _i >= 0; _i--) {
	draw_enclosed_text(
		0, room_width,
		equations_pos[1] - 2 * (array_length(global.equations) - _i) * string_height("1"),
		display_padding,
		parse_equation_from_single_list_to_string(global.equations[_i][0]),
		global.equations[_i][2],
		real(array_length(global.equations) - _i  == global.current_equation_id) * cursor_alpha,
		"left"
	);
	draw_enclosed_text(
		0, room_width,
		equations_pos[1] - (2 * (array_length(global.equations) - _i) - 1) * string_height("1"),
		display_padding,
		parse_equation_from_single_list_to_string(global.equations[_i][1]),
		global.equations[_i][3],
		real(array_length(global.equations) - _i - 0.5 == global.current_equation_id) * cursor_alpha,
		"right"
	);
}

// Display the equation that the user is typing
draw_enclosed_text(
	0, room_width, equations_pos[1], display_padding, 
	parse_equation_from_single_list_to_string(global.current_equation),
	global.cursor_position, 
	real(global.current_equation_id == 0) * cursor_alpha,
	"left"
);
