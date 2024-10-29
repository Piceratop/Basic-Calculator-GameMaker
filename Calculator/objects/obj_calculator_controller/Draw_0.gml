draw_set_valign(fa_bottom);
draw_set_halign(fa_left);
draw_set_color(global.fnt_color);

var _cursor_pixel_position = room_width / 2;
var _after_cursor = string_copy(
	global.current_equation,
	global.cursor_position,
	string_length(global.current_equation) - global.cursor_position + 1
);
var _before_cursor = string_copy(global.current_equation, 1, global.cursor_position - 1);
if (display_padding + string_width(_after_cursor) + 2 < room_width / 2)
	_cursor_pixel_position = room_width - (display_padding + string_width(_after_cursor) + 2);
if (cursor_color == 1)
	draw_rectangle(
		_cursor_pixel_position - 1,
		equations_pos[1] - 4,
		_cursor_pixel_position,
		equations_pos[1] - 28,
		false
	);
draw_text(_cursor_pixel_position + 2, equations_pos[1], _after_cursor);
draw_set_halign(fa_right);
draw_text(_cursor_pixel_position + 2, equations_pos[1], _before_cursor);


// Show debug message on screen
draw_set_halign(fa_left);
//draw_text(10, 40, display_padding + string_width(_after_cursor));
//draw_text(10, 30, global.cursor_position);