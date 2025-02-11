draw_self();

draw_set_valign(fa_middle);
draw_set_halign(fa_right);
draw_text(room_width - margin - 4, y - y_padding / 2, is_dropping ? "▼" : "◀");

if (is_dropping) {
	for (
		var _i = 0; 
		_i < min(3, array_length(options) - current_option_id);
		_i++
	) {
		// TODO: Draw options
	}
}
