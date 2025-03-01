with (obj_dropdown) {
	if (name == other.name)
		if (is_dropping == 1) {
			draw_set_color(global.back_color);
			draw_rectangle(
				x, y, x + sprite_get_width(spr_scroll_button),
				y + sprite_get_height(spr_scroll_button), false
			);
		} 	
}
draw_self();