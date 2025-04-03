switch (options_setting_dropdown[| setting_dropdown.current_option_id][? "label"]) {
	case "Converter":
		draw_text(margin, y_top_label, "Conversion types:");		
		break;
	default:
		show_debug_message($"{options_setting_dropdown[| 0]}");
}