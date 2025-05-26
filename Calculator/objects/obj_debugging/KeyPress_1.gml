
switch(keyboard_lastchar) {
	case "B":
	case "b":
		request = http_get("http://localhost:3000");
		break;
	case "C":
	case "c":
		break;
	case "D":
	case "d":
		while (ds_list_size(global.modes.Standard.displaying_equations) > 0) {
			var _a = global.modes.Standard.equations[| 0][| 0];
			var _b = global.modes.Standard.equations[| 0]| [1];
			array_delete(global.modes.Standard.equations, 0, 1);
			ds_list_destroy_multiple(_a, _b);
			array_delete(global.modes.Standard.displaying_equations, 0, 1);
		}
		json_save("save.bin", []);
		break;
	case "P":
	case "p":
		layer_set_target_room(rm_main);
		var _a = layer_get_all();
		for (var _i = 0; _i < array_length(_a); _i++) {
			show_debug_message(layer_get_name(_a[_i]));
		}
		show_debug_message(layer_get_id("Menu"));
		break;
	case "Q":
	case "q":
		for (var _i = array_length(global.modes.Standard.equations) - 1; _i >= 0; _i--) {
			show_debug_message(ds_list_stringify(global.modes.Standard.equations[_i][1]) + "\n");
		}
		break;
}

