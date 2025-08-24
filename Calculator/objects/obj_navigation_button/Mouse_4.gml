switch (name) {
	case "Practice_Play":
		var _values = global.modes.Practice.values_of_options;
		if (check_valid_praction_option(
			_values[? "Question's length:"][| 0],
			_values[? "Minimum:"][| 0],
			_values[? "Maximum:"][| 0]
		)) {
			global.current_mode = name;
			room_goto(global.modes[$ name].room_id);
		}
		break;
	default:
		global.current_mode = name;
		room_goto(global.modes[$ name].room_id);
}



