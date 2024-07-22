function is_integer(_n) {
	for (var _i = 1; _i <= string_length(_n); _i++) 
		if (string_char_at(_n, _i) == ".")
			return false;
	return true;
}

function normalize(_n){
	if (is_integer(_n))
		_n += ".";
	var _delete_count = 0;
	for (var _i = string_length(_n); string_char_at(_n, _i) == "0"; _i--)
		_delete_count++;
	_n = string_delete(_n, string_length(_n) - _delete_count + 1, _delete_count);
	_n = string_replace(_n, "\u2212", "-");
	_delete_count = 0;
	if (string_char_at(_n, 1) == "-") {
		_n = string_insert("0", _n, 2);
		for (var _i = 2; string_char_at(_n, _i) == "0" && string_char_at(_n, _i + 1) != "."; _i++)
			_delete_count++;
		_n = string_delete(_n, 2, _delete_count);
	} else {
		_n = "0" + _n;
		for (var _i = 1; string_char_at(_n, _i) == "0" && string_char_at(_n, _i + 1) != "."; _i++)
			_delete_count++;
		_n = string_delete(_n, 1, _delete_count);
	}
	if (string_char_at(_n, string_length(_n)) == ".")
		_n = string_delete(_n, string_length(_n), 1);
	if (_n == "-0")
		return "0";
	return _n;
}