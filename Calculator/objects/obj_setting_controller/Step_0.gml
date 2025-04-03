if (not had_layout) {
	switch (options_setting_dropdown[| setting_dropdown.current_option_id][? "label"]) {
		case "Converter":
			var _modes_conversion = ds_list_create();
			for (
				var _k = ds_map_find_first(global.modes.Converter.conversion_rate);
				not is_undefined(_k);
				_k = ds_map_find_next(global.modes.Converter.conversion_rate, _k)
			) {
					dropdown_add_options(_modes_conversion, _k);
				}
			var _converter_type_dropdown = dropdown_create(
				room_width / 2, y_top_label + y_gap, "Button", "Converter Type",
				width_dropdown, height_dropdown, _modes_conversion
			);
			
			break;
		default:
			show_debug_message($"{options_setting_dropdown[| 0]}");
	}
	had_layout = true;
}