draw_set_valign(fa_bottom);
draw_set_color(global.fnt_color);

// Display the past equations
draw_set_halign(fa_right);

for (var _i = array_length(global.equations) - 1; _i >= max(0, array_length(global.equations) - 3); _i--) {
	draw_text(
		equations_pos[0],
		equations_pos[1] - 2 * (array_length(global.equations) - _i) * string_height("1"),
		global.equations[_i][0]
	);
	draw_text(
		equations_pos[0],
		equations_pos[1] - (2 * (array_length(global.equations) - _i) - 1) * string_height("1"),
		"=" + global.equations[_i][1]
	);
}

// Display the equation that the user is typing
draw_enclosed_text(
	0, room_width, center_pos[1] - 3.5 * button_width, display_padding, 
	global.current_equation, global.cursor_position, cursor_alpha
);




// Show debug message on screen

//var _cursor_pixel_position = room_width / 2;
//var _after_cursor = string_copy(
//	global.current_equation,
//	global.cursor_position,
//	string_length(global.current_equation) - global.cursor_position + 1
//);
//var _before_cursor = string_copy(global.current_equation, 1, global.cursor_position - 1);
//if (string_width(global.current_equation) >= room_width - 2 * display_padding) {
//	if (display_padding + string_width(_before_cursor) + 2 < room_width / 2)
//		_cursor_pixel_position = display_padding + string_width(_before_cursor) + 2;
//	if (display_padding + string_width(_after_cursor) + 2 < room_width / 2)
//		_cursor_pixel_position = room_width - (display_padding + string_width(_after_cursor) + 2);
//} else _cursor_pixel_position = room_width - (display_padding + string_width(_after_cursor) + 2);
//if (cursor_color == 1)
//	draw_rectangle(
//		_cursor_pixel_position - 1,
//		equations_pos[1] - 4,
//		_cursor_pixel_position,
//		equations_pos[1] - 28,
//		false
//	);
//draw_text(_cursor_pixel_position + 2, equations_pos[1], _after_cursor);
//draw_set_halign(fa_right);
//if (_cursor_pixel_position + string_width(_after_cursor) >= equations_pos[0]) {
//	draw_rectangle_color(
//		equations_pos[0] - string_width("▶"), equations_pos[1],
//		room_width,	equations_pos[1] - string_height("▶"),
//		global.back_color, global.back_color, global.back_color, global.back_color, false
//	);
//	draw_text(equations_pos[0], equations_pos[1], "▶");
//}
//draw_text(_cursor_pixel_position + 2, equations_pos[1], _before_cursor);
//draw_set_halign(fa_left);
//if (_cursor_pixel_position - string_width(_before_cursor) <= display_padding) {
//	draw_rectangle_color(
//		display_padding + string_width("◀"), equations_pos[1],
//		-2,	equations_pos[1] - string_height("◀"),
//		global.back_color, global.back_color, global.back_color, global.back_color, false
//	);
//	draw_text(display_padding, equations_pos[1], "◀");
//}

//draw_text(10, 40, display_padding + string_width(_after_cursor));
//draw_text(10, 30, global.cursor_position);