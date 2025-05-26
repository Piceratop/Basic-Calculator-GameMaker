function update_layer() {
	layer_reset_target_room();
	if (global.current_mode == "Menu") {
		layer_set_visible("Menu", true);
	} else {
		layer_set_visible("Menu", false);
	}
}