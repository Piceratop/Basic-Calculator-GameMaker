#region This code will change the layout of the setting page.
if (not had_layout) {
	switch (options_setting_dropdown[| setting_dropdown.current_option_id][? "label"]) {
		case "Converter":
			var _modes_conversion = ds_list_create();
			for (
				var _k = ds_map_find_first(global.modes.Converter.conversion_rate);
				not is_undefined(_k);
				_k = ds_map_find_next(global.modes.Converter.conversion_rate, _k)
			) { 
            dropdown_options_add(_modes_conversion, _k);
			}
         
         var _converter_type_dropdown_pos = flexpanel_node_layout_get_position(
            flexpanel_node_get_child(global.modes.Setting.flex_option, 1), false
         );
			var _converter_type_dropdown = dropdown_create(
				_converter_type_dropdown_pos.left, _converter_type_dropdown_pos.top,
            "Button", "Converter Type",
				width_dropdown, height_dropdown, 0, _modes_conversion, false, "", 0, "Conversion types:"
			);
			with (_converter_type_dropdown) {
				while (options[| current_option_id][? "value"] != global.modes.Converter.convert_mode) {
					current_option_id++;
				}
			}
			break;
	}
	had_layout = true;
}
#endregion

#region This code will change the type of converting units.
with (obj_dropdown) {
	if (name == "Converter Type") {
		global.modes.Converter.convert_mode = options[| current_option_id][? "value"];
	}
}
#endregion