if (keyboard_check_pressed(vk_anykey)) {
	if (keyboard_lastchar == "P" || keyboard_lastchar == "p") {
		for (var _i = 0; _i < 10; _i++)
		if (ds_exists(_i, ds_type_list)) {
			show_debug_message($"{_i} {ds_list_stringify(_i)}");
		}
	}
	if (keyboard_lastchar == "Q" || keyboard_lastchar == "q") {
		show_debug_message($"{global.equations}");
	}
	if (keyboard_lastchar == "D" || keyboard_lastchar == "d") {
		
	}
}
