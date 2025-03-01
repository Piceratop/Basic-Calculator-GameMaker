with (obj_dropdown) {
	if (name == other.name)
		if (is_dropping == 1) {
			other.image_alpha = 1;
		} else {
			other.image_alpha = 0;
		}
}