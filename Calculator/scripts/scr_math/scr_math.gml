/**
 * @function			get_decimal_position(_n)
 * @description		Get the position of the decimal place in the number.
 *							If the number is an integer, return 0.
 * @param {String}	_n - The input value to check.
 * @return {Real}
 */

function get_decimal_position(_n) {
	for (var _i = 1; _i <= string_length(_n); _i++) 
		if (string_char_at(_n, _i) == ".")
			return _i;
	return 0;
}

/**
 * @function			is_negative(_n)
 * @description		Checks if the given input is a negative number.
 * @param {String}	_n - The input value to check.
 * @return {Bool}
 */

function is_negative(_n) {
	return string_char_at(_n, 1) == "-" || string_char_at(_n, 1) == "\u2212";
}

/**
 * @function			normalize(_n)
 * @description		Normalizes the input value by removing trailing zeros,
							replacing "-" with the minus sign (U+2212),
 *							and ensuring consistent formatting.
 * @param {String}	_n - The input value to normalize.
 * @returns {String}
 */

function normalize(_n){
	if (get_decimal_position(_n) == 0)
		_n += ".";
	var _delete_count = 0;
	for (var _i = string_length(_n); string_char_at(_n, _i) == "0"; _i--)
		_delete_count++;
	_n = string_delete(_n, string_length(_n) - _delete_count + 1, _delete_count);
	_n = string_replace(_n, "\u2212", "-");
	_delete_count = 0;
	if (is_negative(_n)) {
		_n = string_insert("0", _n, 2);
		for (var _i = 2; string_char_at(_n, _i) == "0"
		&& string_char_at(_n, _i + 1) != "."; _i++)
			_delete_count++;
		_n = string_delete(_n, 2, _delete_count);
	} else {
		_n = "0" + _n;
		for (var _i = 1; string_char_at(_n, _i) == "0"
		&& string_char_at(_n, _i + 1) != "."; _i++)
			_delete_count++;
		_n = string_delete(_n, 1, _delete_count);
	}
	if (string_char_at(_n, string_length(_n)) == ".")
		_n = string_delete(_n, string_length(_n), 1);
	if (_n == "-0")
		return "0";
	return _n;
}

/**
 * @function			absolute_value(_n)
 * @description		Calculates the absolute value of the input value.
 * @param {String}	_n - The input value.
 * @returns {String}
 */

function absolute_value(_n) {
	if (is_negative(_n)) _n = string_delete(_n, 1, 1);
	return normalize(_n);
}

function ceiling_s(_n) {
	if (is_negative(_n))	return inverse_s(floor_s(inverse_s(_n)));
	for (var _i = 1; _i <= string_length(_n); _i++)
		if (string_char_at(_n, _i) == ".") {
			var _truncated = string_delete(_n, _i, string_length(_n));
			if (string_char_at(_n, _i + 1) == "0") _n = _truncated;
			else _n = add(_truncated, "1")
		}
	return normalize(_n);
}

function floor_s(_n) {
	if (is_negative(_n))	return inverse_s(ceiling_s(inverse_s(_n)));
	for (var _i = 1; _i <= string_length(_n); _i++)
		if (string_char_at(_n, _i) == ".")
			_n = string_delete(_n, _i, string_length(_n));
	return normalize(_n);
}

/**
 * @function			inverse_s(_n)
 * @description		Calculates the inverse of the input value.
 *							If the input is negative, returns the positive value.
 *							If the input is positive, returns the negated value.
 * @param {String}	_n - The input value.
 * @returns {String} The inverse value.
 */

function inverse_s(_n) {
	if (is_negative(_n)) return normalize(string_delete(_n, 0, 1));
	return normalize("\u2212" + _n);
}

/**
 * @function						normalize_similar_form(_a, _b)
 *	@description					Normalizes two similar values to have the same number 
 *										of decimal places.
 *										If either value is an integer, it adds a decimal point.
 *										If one value has more decimal places than the other,
 *										it pads with zeros.
 * @param {String}				_a - The first value.
 * @param {String}				_b - The second value.
 * @returns {Array<String>}
 */

function normalize_similar_form(_a, _b) {
	_a = normalize(_a); _b = normalize(_b);
	var _decimal_a = get_decimal_position(_a);
	if (_decimal_a == 0) {
		_a += ".";
		_decimal_a = string_length(_a);
	}
	var _decimal_b = get_decimal_position(_b);
	if (_decimal_b == 0) {
		_b += ".";
		_decimal_b = string_length(_b);
	}
	var _i;
	for (_i = _decimal_a; _i < _decimal_b; _i++) _a = "0" + _a;
	for (_i = _decimal_b; _i < _decimal_a; _i++) _b = "0" + _b;
	var _sa = string_length(_a);
	var _sb = string_length(_b);
	for (_i = _sa; _i < _sb; _i++) _a += "0";
	for (_i = _sb; _i < _sa; _i++) _b += "0";
	return [_a, _b];
}

/**
 * @function						compare(_a, _b
 *	@description					Compare two numbers. Return -1 if the first number is 
 *										smaller, 0 if the two number has the same value, 1 if
 *										the first number if bigger.
 * @param {String}				_a - The first value.
 * @param {String}				_b - The second value.
 * @returns {Real}
 */

function compare(_a, _b) {
	_a = normalize(_a); _b = normalize(_b);
	var _is_both_negative = 0;
	if (string_char_at(_a, 1) == "-")
		_is_both_negative += 1;
	if (string_char_at(_b, 1) == "-")
		_is_both_negative += 2;
	switch (_is_both_negative) {
		case 1:
			return -1;
		case 2:
			return 1;
	}
	var _nml = normalize_similar_form(_a, _b);
	_a = _nml[0]; _b = _nml[0];
	for (var _i = 1; _i <= string_length(_a); _i++) {
		var _ord_ai = ord(string_char_at(_a, _i));
		var _ord_bi = ord(string_char_at(_b, _i));
		if (_ord_ai > _ord_bi) {
			if (_is_both_negative == 3) return -1;
			return 1;
		} else if (_ord_ai < _ord_bi) {
			if (_is_both_negative == 3) return 1;
			return -1;
		}
	}
	return 0;
}