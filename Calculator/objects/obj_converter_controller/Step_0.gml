// This code updates converting units for both input and output.
with (obj_dropdown) {
   if (ds_list_size(options) > 0) {
   	switch (name) {
   		case "input":
   			global.modes.Converter.input_unit = options[| current_option_id][? "value"];
   			break;
   		case "output":
   			global.modes.Converter.output_unit = options[| current_option_id][? "value"];
   			break;
   	}
   }
}

// This code set the display to be the current values of the input and output
with (obj_display_box) {
	switch (name) {
		case "input":
			value = parse_equation_from_single_list_to_string(global.modes.Converter.current_equation);
			cursor_alpha = global.cursor_alpha;
			cursor_position = global.modes.Converter.cursor_position;
			break;
		case "output":
			value = parse_equation_from_single_list_to_string(global.modes.Converter.converted);
			break;
	}
}