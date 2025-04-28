draw_self();
var _temp_valign = draw_get_valign();
draw_set_valign(fa_bottom);
draw_enclosed_text(
	x - width / 2, x + width / 2, y + 16, 8, value,
	cursor_position, cursor_alpha, global.fnt_color, "left"
);

draw_enclosed_text(
	x - width / 2, x + width / 2, y - 12 - margin, -4, label,
	0, 0, global.fnt_color, "left"
);
draw_set_valign(_temp_valign);