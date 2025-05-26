if (keyboard_lastchar == "p") {
	var _a = layer_get_all();
	for (var _i = 0; _i < array_length(_a); _i++) {
		show_debug_message(layer_get_name(_a[_i]));
	}
	show_debug_message(layer_get_id("Menu"));
}