// This code initializes the variables needed to layout settings
margin = 32;
height_dropdown = 48;
width_dropdown = room_width - 64;
y_gap = 48;

had_layout = false;

// This code creates a dropdown menu to store the current mode's setting to be changed.
options_setting_dropdown = ds_list_create();
dropdown_add_options(options_setting_dropdown, "Converter");

setting_dropdown = dropdown_create(
	room_width / 2, 80, "Button", "Mode Selection",
	width_dropdown, height_dropdown,
	options_setting_dropdown
)
y_top_label = setting_dropdown.y + 32;