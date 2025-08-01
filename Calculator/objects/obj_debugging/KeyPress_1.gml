
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
		show_debug_message(ds_list_size(global.modes.Practice.option_id_mapping));
		break;
}

