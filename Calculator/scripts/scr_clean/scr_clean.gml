/**
 * @function				ds_list_destroy_all
 * @description			This function will destroy the list and all of its sublist elements.
 * @param {Id.DsList}	_list - The list to be destroyed.
 */
 
function ds_list_destroy_all(_list) {
	for (var _i = 0; _i < ds_list_size(_list); _i++) {
		var _element_current = _list[| _i];
		if (typeof(_element_current) == "ref") {
			if (ds_exists(_element_current, ds_type_list)) {
				ds_list_destroy_all(_element_current);
			} else if (ds_exists(_element_current, ds_type_map)) {
				ds_map_destroy(_element_current);
			}
		}
	}
	ds_list_destroy(_list);
}

/**
 * @function				ds_list_destroy_multiple
 * @description			This function will destroy all given lists.
 */

function ds_list_destroy_multiple() {
	for (var _i = 0; _i < argument_count; _i++)
		ds_list_destroy(argument[_i]);
}

/** 
 * @function					room_clean_goto
 * @description				This function will clean all the leftover ds_list and ds_map, then change the room.
 *									Must be used in end step.
 * @param {Asset.GMRoom}	_room - The room to go to
 * @param {String}			_mode - The mode of the room to go to
 */

function room_clean_goto(_room, _mode) {
	// This code frees the dropdowns
	with (obj_dropdown) {
		dropdown_destroy(self);
	}
	
	// This code resets the setting.
	ds_list_clear(global.modes.Practice.option_id_mapping);
	ds_map_clear(global.modes.Practice.values_of_options);
	
	// This code changes the room
	global.current_mode = _mode;
	room_goto(_room);
}