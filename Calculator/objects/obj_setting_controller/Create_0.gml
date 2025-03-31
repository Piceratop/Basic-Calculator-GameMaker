// This code sets the dimensions and spacing for the dropdown menu.
height_dropdown = 32;
width_dropdown = room_width - 64;
margin_dropdown_text = 32;

// This code creates a dropdown menu to store the current mode's setting to be changed.
options_setting_dropdown = ds_list_create();
dropdown_add_options(options_setting_dropdown, "Converter");

//setting_dropdown = instance_create_layer(
//	room_width / 2, 
//	80,
//	"Button",
//	obj_dropdown, 
//   {
//		dropdown_height: height_dropdown,
//      image_xscale: width_dropdown / sprite_get_width(spr_border),
//      margin: margin_dropdown_text,
//      name: "Mode Selection",
//		options: options_setting_dropdown
//   }
//);

setting_dropdown = dropdown_create(
	room_width / 2, 80, "Button", "Mode Selection",
	width_dropdown, height_dropdown,
	options_setting_dropdown
)

// This codes initialize the variables needed to layout settings
had_layout = false;