switch (name) {
	case "Practice_Play":
		var _practice = global.modes.Practice;
		var _values = _practice.option_id_mapping[? _practice.practice_mode];
		if (check_valid_praction_option(
			_values[? "Question's length"][| global.store_pos_equation],
			_values[? "Minimum"][| global.store_pos_equation],
			_values[? "Maximum"][| global.store_pos_equation],
			_values[? "No. decimal places"][| global.store_pos_equation]
		)) {
			global.current_mode = name;
			room_goto(global.modes[$ name].room_id);
		}
		break;
	default:
		global.current_mode = name;
		room_goto(global.modes[$ name].room_id);
}



