// This code sets the dimensions and spacing for the dropdown menu.
height_dropdown = 48;
width_dropdown = room_width - 64;
margin_dropdown_text = 32;

// The code creates a list to store dropdown options.
options_setting_dropdown = ds_list_create();
ds_list_add(options_setting_dropdown, "Converter");

// This code creates a dropdown menu instance.
setting_dropdown = instance_create_layer(
	room_width / 2, 
	room_width / 4,
	"Button",
	obj_dropdown, 
   {
		dropdown_height: height_dropdown,
      image_xscale: width_dropdown / sprite_get_width(spr_border),
      margin: margin_dropdown_text,
      name: "Mode Selection",
		options: options_setting_dropdown
   }
);