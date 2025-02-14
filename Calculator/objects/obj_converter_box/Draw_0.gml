draw_set_valign(fa_bottom);

draw_enclosed_text(
	0, room_width, y + 16, 48,
	parse_equation_from_single_list_to_string(global.modes.Converter.current_equation),
	global.modes.Converter.cursor_position, global.cursor_alpha, global.fnt_color, "left"
);

draw_self();