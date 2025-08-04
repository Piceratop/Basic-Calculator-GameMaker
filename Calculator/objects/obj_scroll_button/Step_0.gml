with (obj_dropdown) {
	if (name == other.name) {
		if (is_dropping == 1) {
			other.image_alpha = 1;
		} else {
			other.image_alpha = 0;
		}
		
		// Set the position of the scroll buttons
		if (other.type == "up") {
			other.y = y + dropdown_height;
		} else {
			other.y = y + (count_showing_options + 1) * dropdown_height - sprite_get_height(spr_scroll_button);
		}
	}
}