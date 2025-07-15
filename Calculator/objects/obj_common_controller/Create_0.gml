str_layer_back_btn = "BackButton";
str_layer_menu = "Menu";
str_layer_setting_btn = "SettingButton";

function update_layer() {
	layer_reset_target_room();
	if (global.current_mode == "Menu") {
		layer_set_visible(str_layer_menu, true);
		layer_set_visible(str_layer_back_btn, false);
		layer_set_visible(str_layer_setting_btn, false);
	} else {
		layer_set_visible(str_layer_menu, false);
		layer_set_visible(str_layer_back_btn, true);
		layer_set_visible(str_layer_setting_btn, global.modes[$ global.current_mode].mode_id >= 0);
	}		
}

alarm[0] = game_get_speed(gamespeed_fps);