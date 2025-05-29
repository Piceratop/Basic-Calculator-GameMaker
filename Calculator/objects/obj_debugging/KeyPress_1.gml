
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
		layer_reset_target_room();
		var _s = layer_get_flexpanel_node("Menu");
		show_debug_message(flexpanel_node_get_struct(_s));
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

