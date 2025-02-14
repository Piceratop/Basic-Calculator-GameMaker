draw_self();

draw_set_valign(fa_middle);
draw_set_halign(fa_right);
draw_text(room_width - margin - 4, y - y_padding / 2, is_dropping ? "▼" : "◀");

if (is_dropping) {
	// TODO: Draw options

}
