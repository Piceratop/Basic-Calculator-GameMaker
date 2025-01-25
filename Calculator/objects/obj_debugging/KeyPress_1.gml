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
		while (array_length(global.displaying_equations) > 0) {
			var _a = global.equations[0][0];
			var _b = global.equations[0][1];
			array_delete(global.equations, 0, 1);
			ds_list_destroy_multiple(_a, _b);
			array_delete(global.displaying_equations, 0, 1);
		}
		
		json_save("save.bin", []);
	}
}
