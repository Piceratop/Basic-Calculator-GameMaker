/**
 * @function				get_decimal_position(_n)
 * @description				Get the position of the decimal place in the number.
 *							If the number is an integer, return 0.
 * @param {Array<Real>}		_n - The input value to check.
 * @return {Real}
 */

function get_decimal_position(_n) {
	var _f = function(_element, _index) {
		return _element == 10
	}
	return array_find_index(_n, _f);
}


/**
 * @function			is_negative(_n)
 * @description			Checks if the given input is a negative number.
 * @param {Array<Real>}	_n - The input value to check.
 * @return {Bool}
 */

function is_negative(_n) {
	return _n[0] == 10;
}

/**
 * @function			normalize(_n)
 * @description			Normalizes the input value by removing trailing zeros,
						replacing "-" with the minus sign (U+2212),
 *						and ensuring consistent formatting.
 * @param {Array<Real>}	_n - The input value to normalize.
 * @returns {Array<Real>}
 */

function normalize(_n){
	var _i = array_length(_n) - 1;
	if (get_decimal_position(_n) != -1)
		for (; _n[_i] == 0; _i--)
			array_pop(_n);
	if (_n[_i] == 10) array_pop(_n);
	for (_i = 0; _n[_i] == 0; _i++)
		array_shift(_n);
	if (array_equals(_n, [10])) _n[0] = 0;
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
 * @function			ceiling_decimal(_n, _precision)
 * @description		Calculates the ceiling value of a numeric string with
 *							a specified precision.
 * @param {String}	_n - The input numeric string.
 * @param {Real}		_precision - The desired precision (number of decimal places).
 * @returns {String}
 */
function ceiling_decimal(_n, _precision = 0) {
	return shift_decimal(ceiling_s(shift_decimal(_n, _precision)), -_precision);
}

/**
 * @function			ceiling_s(_n)
 * @description		Rounds up a numeric value to the nearest integer.
 * @param {String}	_n - The input value.
 * @returns {String}
 */

function ceiling_s(_n) {
	if (is_negative(_n))	return inverse(floor_s(inverse(_n)));
	_n = normalize(_n);
	var _dn = get_decimal_position(_n);
	if (_dn > string_length(_n)) return _n;
	else return add(string_delete(_n, _dn, string_length(_n)), "1");
}

/**
 * @function			ceiling_decimal(_n, _precision)
 * @description		Calculates the floor value of a numeric string with
 *							a specified precision.
 * @param {String}	_n - The input numeric string.
 * @param {Real}		_precision - The desired precision (number of decimal places).
 * @returns {String}
 */

function floor_decimal(_n, _precision = 0) {
	return shift_decimal(floor_s(shift_decimal(_n, _precision)), -_precision);
}

/**
 * @function			floor_s(_n)
 * @description		Rounds down a numeric value to the nearest integer.
 * @param {String}	_n - The input value.
 * @returns {String}
 */

function floor_s(_n) {
	if (is_negative(_n))	return inverse(ceiling_s(inverse(_n)));
	return normalize(string_delete(_n, get_decimal_position(_n), string_length(_n)));
}

/**
 * @function			inverse(_n)
 * @description		Calculates the inverse of the input value.
 *							If the input is negative, returns the positive value.
 *							If the input is positive, returns the negated value.
 * @param {String}	_n - The input value.
 * @returns {String} The inverse value.
 */

function inverse(_n) {
	if (is_negative(_n)) return normalize(string_delete(_n, 0, 1));
	return normalize("\u2212" + _n);
}

/**
 * @function			round_decimal(_n, _precision)
 * @description		Rounds a number to the specified precision.
 * @param {String}	_n - The input numeric string.
 * @param {Real}		_precision - The desired precision (number of decimal places).
 * @returns {String}
 */

function round_decimal(_n, _precision = 0) {
	var _dn = get_decimal_position(_n);
	var _pos_to_check = _dn + _precision + 1;
	if (_pos_to_check > string_length(_n)) return normalize(_n);
	if (_pos_to_check < 0) return "0";
	if (compare(string_char_at(_n, _pos_to_check), "5") == -1)
		return floor_decimal(_n, _precision);
	else
		return ceiling_decimal(_n, _precision);
}

/**
 * @function			shift_decimal(_n)
 * @description		Shifts the decimal point of a numeric string.
 * @param {String}	_n - The input value.
 * @param {Real}		_shift - The number of positions to shift the decimal point.
 *							If positive, shifts to the right; if negative, shifts to 
 *							the left.
 * @returns {String}
 */

function shift_decimal(_n, _shift) {
	var _dn = get_decimal_position(_n);
	if (_dn > string_length(_n)) _n += ".";
	if (_shift < 0) {
		var _pad = "";
		for (var _i = 0; _i > _shift; _i--)
			_pad += "0";
		_n = _pad + _n;
		_dn -= _shift;
	} else if (_shift > 0) {
		for (var _i = 0; _i < _shift; _i++)
			_n += "0";
	}
	_n = string_delete(_n, _dn, 1);
	_n = string_insert(".", _n, _dn + _shift);
	return normalize(_n);
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
	if (_decimal_a > string_length(_a)) {
		_a += ".";
	}
	var _decimal_b = get_decimal_position(_b);
	if (_decimal_b > string_length(_b)) {
		_b += ".";
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
	if (compare("0", _b) == 1) return subtract(_a, inverse(_b));
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
	if (compare("0", _b) == 1) return add(_a, inverse(_b));
	if (compare("0", _a) == 1) return inverse(add(inverse(_a), _b));
	if (compare(_a, _b) == -1) return inverse(subtract(_b, _a));
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
	if (compare("0", _a) == 1) return inverse(multiply(inverse(_a), _b));
	if (compare("0", _b) == 1) return inverse(multiply(_a, inverse(_b)));
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
 * @param {Real}	_precision - The desired precision (number of decimal
 *							places).
 * @returns {String}
 */

function divide(_a, _b, _precision = 6) {
	if (compare(_a, "0") == -1) return inverse(divide(inverse(_a), _b));
	if (compare(_b, "0") == -1) return inverse(divide(_a, inverse(_b)));
	if (_precision < 0) _precision = 0;
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
	return round_decimal(_ans, _precision);
}

/**
 * @function			get_random_range(_a, _b, _precision)
 *	@description		Get a real number between the two given bounds with a 
 *							specified level of precision.
 * @param {String}	_a - The lower bound.
 * @param {String}	_b - The upper bound.
 * @param {Real}		_precision - The desired precision (number of decimal places).
 * @returns {String}
 */
 
function get_random_range(_a, _b, _precision = 0) {
}