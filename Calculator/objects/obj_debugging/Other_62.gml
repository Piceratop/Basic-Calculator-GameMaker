if (async_load[? "id"] == request) {
	for (
		var _k = ds_map_find_first(async_load);
		not is_undefined(_k);
		_k = ds_map_find_next(async_load, _k)
	) {
		var _v = async_load[? _k];
		show_debug_message($"{_k} {_v}");
	}
}