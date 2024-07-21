switch (label) {
	case "⌫":
		global.current_equation = string_delete(
			global.current_equation,
			string_length(global.current_equation),
			1
		);
		break;
	default:
		global.current_equation += label;
}