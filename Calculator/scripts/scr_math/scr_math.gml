/**
 * @function					normalize(_m)
 * @description				Normalizes the input value by removing trailing zeros and ensuring consistent formatting.
 * @param {Id.DsList}		_n - The input value to normalize.
 * @returns {Undefined}
 */

function normalize(_n) {
	var _i = ds_list_size(_n) - 1;
	if (ds_list_find_index(_n, 10) != -1)
		for (; _n[| _i] == 0; _i--)
			ds_list_delete(_n, _i);
	if (_n[| _i] == 10)
		ds_list_delete(_n, _i);
	while (_n[| 0] == 11 and _n[| 1] == 11) {
		ds_list_delete(_n, 0);
		ds_list_delete(_n, 0);
	}
	var _start = 0;
	if (_n[| 0] == 11) _start = 1;
	while (ds_list_size(_n) > _start and _n[| _start] == 0)
		ds_list_delete(_n, _start);
	if (ds_list_size(_n) == 0) ds_list_add(_n, 0);
	if (ds_list_size(_n) == 1 and (_n[| 0] == 10 or _n[| 0] == 11)) _n[| 0] = 0;
	if (_n[| _start] == 10) ds_list_insert(_n, _start, 0);
}

/**
 * @function						absolute_value(_n)
 * @description					Calculates the absolute value of the input value.
 * @param {Id.DsList}	_n - The input value.
 * @param {Bool}					_is_normalized - Check if the input is normalized.
 * @returns {Id.DsList}
 */

function absolute_value(_n, _is_normalized=false) {
	if (not _is_normalized) normalize(_n);
	var _ans_list = ds_list_create();
	ds_list_copy(_ans_list, _n);
	if (_ans_list[| 0] == 11) ds_list_delete(_ans_list, 0);
	return _ans_list;
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
 * @function						inverse(_n)
 * @description					Calculates the inverse of the input value.
 *										If the input is negative, returns the positive value.
 *										If the input is positive, returns the negated value.
 * @param {Id.DsList}			_n - The input value.
 * @param {Bool}					_is_normalized - Check if the input is normalized.
 * @returns {Id.DsList<Real>}	The inverse value.
 */

function inverse(_n, _is_normalized=false) {
	if (not _is_normalized) normalize(_n);
	var _ans_list = ds_list_create();
	ds_list_copy(_ans_list, _n);
	if (_ans_list[| 0] == 11)
		ds_list_delete(_ans_list, 0);
	else if (ds_list_size(_ans_list) > 1 or _ans_list[| 0] != 0)
		ds_list_insert(_ans_list, 0, 11);
	return _ans_list;
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
 * @function					shift_decimal(_n)
 * @description				Shifts the decimal point of a given number.
 * @param {Id.DsList}		_n - The input value.
 * @param {Real}				_shift - The number of positions to shift the decimal point.
 *									If positive, shifts to the right; if negative, shifts to 
 *									the left.
 * @param {Bool}				_is_normalized - Check if the input is normalized.
 * @returns {Id.DsList<Real>}
 */

function shift_decimal(_n, _shift, _is_normalized=false) {
	if (not _is_normalized) normalize(_n);
	var _ans_list = ds_list_create();
	ds_list_copy(_ans_list, _n);
	var _dn = ds_list_find_index(_ans_list, 10);
	if (_dn == -1) {
		_dn = ds_list_size(_ans_list);
	} else {
		ds_list_delete(_ans_list, _dn);
	}
	var _decimal_new_pos = _dn + _shift;
	if (_decimal_new_pos > 0 and _decimal_new_pos < ds_list_size(_ans_list)) {
		ds_list_insert(_ans_list, _decimal_new_pos, 10);
	} else if (_decimal_new_pos <= 0) {
		for (; _decimal_new_pos < 0; _decimal_new_pos++)
			ds_list_insert(_ans_list, 0, 0);
		ds_list_insert(_ans_list, 0, 10);
		ds_list_insert(_ans_list, 0, 0);
	} else {
		for (_decimal_new_pos = _decimal_new_pos - ds_list_size(_ans_list); _decimal_new_pos > 0; _decimal_new_pos--)
			ds_list_insert(_ans_list, ds_list_size(_ans_list), 0);
	}
	return _ans_list;
}

/**
 * @function						add(_a, _b)
 *	@description					Adds two real numbers.
 * @param {Id.DsList}			_a - The first addend.
 * @param {Id.DsList}			_b - The second addend.
 * @param {Bool}					_is_normalized - Check if the input is normalized.
 * @returns {Id.DsList}
 */

function add(_a, _b, _is_normalized=false) {
	if (not _is_normalized) {
		normalize(_a);
		normalize(_b);
		if (_a[| 0] == 11 and _b[| 0] == 11) {
			ds_list_delete(_a, 0);
			ds_list_delete(_b, 0);
			var _c = add(_a, _b, true);
			ds_list_insert(_a, 0, 11);
			ds_list_insert(_b, 0, 11);
			ds_list_insert(_c, 0, 11);
			return _c;
		}
		if (_a[| 0] == 11) {
			ds_list_delete(_a, 0);
			var _c = subtract(_b, _a, true);
			ds_list_insert(_a, 0, 11);
			return _c;
		}
		if (_b[| 0] == 11)  {
			ds_list_delete(_b, 0);
			var _c = subtract(_a, _b, true);
			ds_list_insert(_b, 0, 11);
			return _c;
		}
	}
	var _dec_pos_a = ds_list_find_index(_a, 10);
	if (_dec_pos_a == -1) _dec_pos_a = ds_list_size(_a);
	var _dec_pos_b = ds_list_find_index(_b, 10);
	if (_dec_pos_b == -1) _dec_pos_b = ds_list_size(_b);
	var _ans_list = ds_list_create();
	var _carry = 0;
	for (
		var _i = max(ds_list_size(_a) - 1 - _dec_pos_a, ds_list_size(_b) - 1 - _dec_pos_b);
		_i >= min(-_dec_pos_a, -_dec_pos_b);
		_i--
	) {
		if (_i == 0) {
			ds_list_add(_ans_list, 10);
			continue;
		}
		var _digit_a = _a[| _dec_pos_a + _i];
		if (is_undefined(_digit_a)) _digit_a = 0;
		var _digit_b = _b[| _dec_pos_b + _i];
		if (is_undefined(_digit_b)) _digit_b = 0;
		var _ds = _digit_a + _digit_b + _carry;
		ds_list_add(_ans_list, _ds % 10);
		_carry = _ds > 10;
	}
	if (_carry == 1) ds_list_add(_ans_list, 1);
	ds_list_reverse(_ans_list);
	normalize(_ans_list);
	return _ans_list;
}

/**
 * @function				compare(_a, _b)
 *	@description			Compare two numbers. Return -1 if the first number is 
 *								smaller, 0 if the two number has the same value, 1 if
 *								the first number if bigger.
 * @param {Id.DsList}	_a - The first real number.
 * @param {Id.DsList}	_b - The second real number.
 * @param {Bool}			_is_normalized - Check if the input is normalized.
 * @returns {Real}
 */

function compare(_a, _b, _is_normalized=false) {
	if (not _is_normalized) {
		normalize(_a);
		normalize(_b);
	}
	var _is_both_negative = 0;
	if (_a[| 0] == 11)
		_is_both_negative += 1;
	if (_b[| 0] == 11)
		_is_both_negative += 2;
	switch (_is_both_negative) {
		case 1:
			return -1;
		case 2:
			return 1;
	}
	var _dec_pos_a = ds_list_find_index(_a, 10);
	if (_dec_pos_a == -1) _dec_pos_a = ds_list_size(_a);
	var _dec_pos_b = ds_list_find_index(_b, 10);
	if (_dec_pos_b == -1) _dec_pos_b = ds_list_size(_b);
	if (_is_both_negative == 3) {
		if (_dec_pos_a > _dec_pos_b) return -1;
		if (_dec_pos_b > _dec_pos_a) return -1;
	} else {
		if (_dec_pos_a > _dec_pos_b) return 1;
		if (_dec_pos_b > _dec_pos_a) return -1;
	}
	for (var _i = 0; _i < max(ds_list_size(_a), ds_list_size(_b)); _i++) {
		var _cur_a = (_i < ds_list_size(_a)) ? _a[| _i] : 0;
		var _cur_b = (_i < ds_list_size(_b)) ? _b[| _i] : 0;
		if (_is_both_negative == 3) {
			if (_cur_a > _cur_b) return -1;
			if (_cur_b > _cur_a) return 1;
		} else {
			if (_cur_a > _cur_b) return 1;
			if (_cur_b > _cur_a) return -1;
		}
	}	
	return 0;
}

/**
 * @function				subtract(_a, _b)
 * @description			Subtracts two real numbers.
 * @param {Id.DsList}	_a - The minuend.
 * @param {Id.DsList}	_b - The subtrahend.
 * @param {Bool}			_is_normalized - Check if the input is normalized.
 * @returns {Id.DsList}
 */

function subtract(_a, _b, _is_normalized=false) {
	if (not _is_normalized) {
		normalize(_a);
		normalize(_b);
		if (_a[| 0] == 11 and _b[| 0] == 11) {
			ds_list_delete(_b, 0);
			ds_list_delete(_a, 0);
			var _c = subtract(_b, _a, true);
			ds_list_insert(_a, 0, 11);
			ds_list_insert(_b, 0, 11);
			return _c;
		}
		if (_a[| 0] == 11) {
			ds_list_delete(_a, 0);
			var _c = add(_a, _b, true);
			ds_list_insert(_a, 0, 11);
			ds_list_insert(_c, 0, 11);
			return _c;
		}
		if (_b[| 0] == 11) {
			ds_list_delete(_b, 0);
			var _c = add(_a, _b, true);
			ds_list_insert(_b, 0, 11);
			return _c;
		}
	}
	var _dec_pos_a = ds_list_find_index(_a, 10);
	if (_dec_pos_a == -1) _dec_pos_a = ds_list_size(_a);
	var _dec_pos_b = ds_list_find_index(_b, 10);
	if (_dec_pos_b == -1) _dec_pos_b = ds_list_size(_b);
	var _ans_list = ds_list_create();
	if (compare(_a, _b) == -1) {
		var _borrow = 0;
		for (
			var _i = max(ds_list_size(_a) - 1 - _dec_pos_a, ds_list_size(_b) - 1 - _dec_pos_b);
			_i >= min(-_dec_pos_a, -_dec_pos_b);
			_i--
		) {
			if (_i == 0) {
				ds_list_add(_ans_list, 10);
				continue;
			}
			var _digit_a = _a[| _dec_pos_a + _i];
			if (is_undefined(_digit_a)) _digit_a = 0;
			var _digit_b = _b[| _dec_pos_b + _i];
			if (is_undefined(_digit_b)) _digit_b = 0;
			var _ds = _digit_b - _digit_a - _borrow;
			if (_ds < 0) {
				_ds += 10;
				_borrow = 1;
			} else _borrow = 1;
			ds_list_add(_ans_list, _ds);
		}
		ds_list_add(_ans_list, 11);
		ds_list_reverse(_ans_list);
	} else {
		var _borrow = 0;
		for (
			var _i = max(ds_list_size(_a) - 1 - _dec_pos_a, ds_list_size(_b) - 1 - _dec_pos_b);
			_i >= min(-_dec_pos_a, -_dec_pos_b);
			_i--
		) {
			if (_i == 0) {
				ds_list_add(_ans_list, 10);
				continue;
			}
			var _digit_a = _a[| _dec_pos_a + _i];
			if (is_undefined(_digit_a)) _digit_a = 0;
			var _digit_b = _b[| _dec_pos_b + _i];
			if (is_undefined(_digit_b)) _digit_b = 0;
			var _ds = _digit_a - _digit_b - _borrow;
			if (_ds < 0) {
				_ds += 10;
				_borrow = 1;
			} else _borrow = 0;
			ds_list_add(_ans_list, _ds);
		}
		ds_list_reverse(_ans_list);
	}
	normalize(_ans_list);
	return _ans_list;
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