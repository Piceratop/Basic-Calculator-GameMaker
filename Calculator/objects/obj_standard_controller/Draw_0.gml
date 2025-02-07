draw_set_valign(fa_bottom);
draw_set_color(global.fnt_color);

// Display past equations

for (var _i = array_length(global.modes.Standard.equations) - 1; _i >= 0; _i--) {
	var _cursor_position = 0;
	draw_enclosed_text(
		0, room_width,
		equations_pos[1] - 2 * (array_length(global.modes.Standard.equations) - _i) * string_height("1"),
		display_padding,
		parse_equation_from_single_list_to_string(global.modes.Standard.equations[_i][0]),
		get_before_cursor_char_count(
			global.modes.Standard.equations[_i][0],
			global.modes.Standard.equations[_i][2]
		),
		real(array_length(global.modes.Standard.equations) - _i  == global.modes.Standard.current_equation_id) * global.cursor_alpha,
		"left"
	);

	draw_enclosed_text(
		0, room_width,
		equations_pos[1] - (2 * (array_length(global.modes.Standard.equations) - _i) - 1) * string_height("1"),
		display_padding,
		parse_equation_from_single_list_to_string(global.modes.Standard.equations[_i][1]),
		//global.modes.Standard.displaying_equations[_i][1],
		get_before_cursor_char_count(
			global.modes.Standard.equations[_i][1],
			global.modes.Standard.equations[_i][3]
		),
		real(array_length(global.modes.Standard.equations) - _i - 0.5 == global.modes.Standard.current_equation_id) * global.cursor_alpha,
		"right"
	);
}

// Removing top overflow

var _cc = draw_get_color();
draw_set_color(global.back_color);
draw_rectangle(0, 0, room_width, 64, false);
draw_set_color(_cc);

// Display the equation that the user is typing

draw_enclosed_text(
	0, room_width, equations_pos[1], display_padding, 
	parse_equation_from_single_list_to_string(global.modes.Standard.current_equation),
	get_before_cursor_char_count(
		global.modes.Standard.current_equation,
		global.modes.Standard.cursor_position
	),
	real(global.modes.Standard.current_equation_id == 0) * global.cursor_alpha,
	"left"
);
