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

/**
 * @function			ceiling_s(_n)
 * @description		Rounds up a numeric value to the nearest integer.
 * @param {String}	_n - The input value.
 * @returns {String}
 */

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

/**
 * @function			floor_s(_n)
 * @description		Rounds down a numeric value to the nearest integerr.
 * @param {String}	_n - The input value.
 * @returns {String}
 */

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
 * @function			compare(_a, _b)
 *	@description		Compare two numbers. Return -1 if the first number is 
 *							smaller, 0 if the two number has the same value, 1 if
 *							the first number if bigger.
 * @param {String}	_a - The first real number.
 * @param {String}	_b - The second real number.
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
	_a = _nml[0]; _b = _nml[1]; 
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

/**
 * @function			add(_a, _b)
 *	@description		Adds two real numbers represented as string.
 * @param {String}	_a - The first addend.
 * @param {String}	_b - The second addend.
 * @returns {String}
 */

function add(_a, _b) {
	if (compare(_a, _b) == -1) return add(_b, _a);
	if (compare("0", _b) == 1) return subtract(_a, inverse_s(_b));
	var _nml = normalize_similar_form(_a, _b);
	_a = _nml[0]; _b = _nml[1]; 
	var _reverse_ans = "";
	var _carry = 0;
	for (var _i = string_length(_a); _i > 0; _i--) {
		if (string_char_at(_a, _i) == ".") {
			_reverse_ans += ".";
			continue;
		}
		var _s = real(string_char_at(_a, _i)) + real(string_char_at(_b, _i)) + _carry;
		_reverse_ans += string(_s % 10);
		_carry = floor(_s / 10);
	}
	return normalize(string_reverse(_reverse_ans + string(_carry)));
}

/**
 * @function			subtract(_a, _b)
 *	@description		Subtracts two real numbers represented as string.
 * @param {String}	_a - The minuend.
 * @param {String}	_b - The subtrahend.
 * @returns {String}
 */

function subtract(_a, _b) {
	if (compare("0", _b) == 1) return add(_a, inverse_s(_b));
	if (compare("0", _a) == 1) return inverse_s(add(inverse_s(_a), _b));
	if (compare(_a, _b) == -1) return inverse_s(subtract(_b, _a));
	var _nml = normalize_similar_form(_a, _b);
	_a = _nml[0]; _b = _nml[1];
	var _reverse_ans = "";
	var _borrow = 0;
	for (var _i = string_length(_a); _i > 0; _i--) {
		if (string_char_at(_a, _i) == ".") {
			_reverse_ans += ".";
			continue;
		}
		var _d = real(string_char_at(_a, _i)) - real(string_char_at(_b, _i)) - _borrow;
		if (_d < 0) {
			_d += 10;
			_borrow = 1;
		} else
			_borrow = 0;
		_reverse_ans += string(_d);
	}
	return normalize(string_reverse(_reverse_ans));
}

/**
 * @function			int_multiply(_a, _b)
 *	@description		Multiplies two integers represented as string.
 * @param {String}	_a - The multiplier.
 * @param {String}	_b - The multiplicand.
 * @returns {String}
 */

function int_multiply(_a, _b) {
	var _nml = normalize_similar_form(_a, _b);
	_a = string_delete(_nml[0], string_length(_nml[0]), 1); 
	_b = string_delete(_nml[1], string_length(_nml[1]), 1);
	var _sa = string_length(_a);
	var _sb = string_length(_b);
	if (_sa > 6) {
		var _a_h = string_delete(_a, 1 + floor(_sa / 2), _sa);
		var _a_l = string_delete(_a, 1, floor(_sa / 2));
		var _b_h = string_delete(_b, 1 + floor(_sb / 2), _sb);
		var _b_l = string_delete(_b, 1, floor(_sb / 2));
		var _c1 = int_multiply(_a_h, _b_h);
		var _c3 = int_multiply(_a_l, _b_l);
		var _d = add(_a_h, _a_l);
		var _e = add(_b_h, _b_l);
		var _c2 = subtract(subtract(int_multiply(_d, _e), _c1), _c3);
		for (var _i = 0; _i < string_length(_a_l) * 2; _i++) _c1 += "0";
		for (var _i = 0; _i < string_length(_a_l); _i++) _c2 += "0";
		return add(add(_c1, _c2), _c3);
	} else return string(real(_a) * real(_b));
}

/**
 * @function			multiply(_a, _b)
 *	@description		Multiplies two real numbers represented as string.
 * @param {String}	_a - The dividend.
 * @param {String}	_b - The divisor.
 * @returns {String}
 */
 
function multiply(_a, _b) {
	if (compare("0", _a) == 1) return inverse_s(multiply(inverse_s(_a), _b));
	if (compare("0", _b) == 1) return inverse_s(multiply(_a, inverse_s(_b)));
	var _nml = normalize_similar_form(_a, _b);
	_a = _nml[0]; _b = _nml[1];
	var _da = get_decimal_position(_a);
	var _db = get_decimal_position(_b);
	var _shift = string_length(_a) - _da + string_length(_b) - _db;
	_a = string_delete(_a, _da, 1);
	_b = string_delete(_b, _db, 1);
	var _ans = int_multiply(_a, _b);
	for (var _i = 0; _i < _shift; _i++)
		_ans = "0" + _ans;
	return normalize(string_insert(".", _ans, string_length(_ans) - _shift + 1));
}
 
 
/**
 * @function			divide(_a, _b, _precision)
 *	@description		Divides two numbers with a specified level of precision.
 * @param {String}	_a - The dividend.
 * @param {String}	_b - The divisor.
 * @param {string}	_precision - The desired precision (number of decimal
 *							places).
 * @returns {String}
 */
function divide(_a, _b, _precision="6") {
	if (compare(_a, "0") == -1) return inverse_s(divide(inverse_s(_a), _b));
	if (compare(_b, "0") == -1) return inverse_s(divide(_a, inverse_s(_b)));
	if (compare(_precision, "0") == -1) _precision = "0";
	var _nml = normalize_similar_form(_a, _b);
	_a = normalize(string_replace(_nml[0], ".", "")); 
	_b = normalize(string_replace(_nml[1], ".", "")); 
	var _error = "0."
	for (var _i = 0; _i < string_length(_a) + _precision; _i++)
		_error += "0";
	_error += "1";
	var _reci = "0.";
	for (var _i = 1; _i < string_length(_b); _i++)
		_reci += "0";
	_reci += "1";
	var _se = string_length(_error);
	while (true) {
		var _new_reci = multiply(_reci, subtract("2", multiply(_b, _reci)));
		_new_reci = string_delete(_new_reci, _se + 2, string_length(_new_reci));
		if (compare(subtract(_new_reci, _reci), _error) = -1) break;
		_reci = _new_reci;
	}
	if (string_length(_reci) > _se && compare(string_char_at(_reci, _se + 1), "4") == 1)
		_reci = add(_reci, _error);
	_reci = string_delete(_reci, _se + 1, string_length(_reci));
	var _ans = multiply(_a, _reci);
	return normalize(_ans);
}