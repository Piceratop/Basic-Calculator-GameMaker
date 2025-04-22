draw_self();

draw_set_valign(fa_bottom);

draw_enclosed_text(
	x - width / 2, x + width / 2, y + 16, 12,
	parse_equation_from_single_list_to_string(value),
	cursor_position, global.cursor_alpha, global.fnt_color, "left"
);