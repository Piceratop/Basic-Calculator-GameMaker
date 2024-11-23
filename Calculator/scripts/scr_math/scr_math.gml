/**
 * @function						normalize(_m)
 * @description					This function will normalize the input value by removing trailing zeros and ensuring consistent formatting.
 *										Also, it will return [ -1 ] if the input cannot be normalized.
 * @param {Id.DsList<Real>}	_n - The input value to normalize.
 * @returns {Undefined}
 */

function normalize(_n) {
	/*
	 * Count the number of decimal point symbol in the number.
	 * Return unnormalizable if there are 2 decimal points or more.
	 * Mix into the loop is also a check for invalid negative sign position.
	 */
	var _count_decimal = 0;
	for (var _i = 0; _i < ds_list_size(_n); _i++) {
		if (_n[| _i] == global.math_encoding_map[? "."]) {
			_count_decimal++;
			if (_count_decimal > 1) {
				ds_list_clear(_n);
				ds_list_add(_n, -1);
				return;
			}
		} else if (_n[| _i] == global.math_encoding_map[? "-"] and _i > 0 and _n[| _i - 1] != global.math_encoding_map[? "-"]) {
			ds_list_clear(_n);
			ds_list_add(_n, -1);
			return;
		}
	}
	

	
	var _i = ds_list_size(_n) - 1;
	if (_count_decimal == 0)
		for (; _n[| _i] == 0; _i--)
			ds_list_delete(_n, _i);
	if (_n[| _i] == global.math_encoding_map[? "."])
		ds_list_delete(_n, _i);
	while (_n[| 0] == global.math_encoding_map[? "-"] and _n[| 1] == global.math_encoding_map[? "-"]) {
		ds_list_delete(_n, 0);
		ds_list_delete(_n, 0);
	}
	var _start = 0;
	if (_n[| 0] == global.math_encoding_map[? "-"]) _start = 1;
	while (ds_list_size(_n) > _start and _n[| _start] == 0)
		ds_list_delete(_n, _start);
	if (ds_list_size(_n) == 0) ds_list_add(_n, 0);
	if (ds_list_size(_n) == 1 and (_n[| 0] == global.math_encoding_map[? "."] or _n[| 0] == global.math_encoding_map[? "-"])) _n[| 0] = 0;
	if (_n[| _start] == global.math_encoding_map[? "."]) ds_list_insert(_n, _start, 0);
}

/**
 * @function						absolute_value(_n, _is_normalized)
 * @description					Calculates the absolute value of the input value.
 * @param {Id.DsList<Real>}	_n - The input value.
 * @param {Bool}					_is_normalized - Check if the input is normalized.
 * @returns {Id.DsList<Real>}
 */

function absolute_value(_n, _is_normalized = false) {
	if (not _is_normalized) normalize(_n);
	var _ans_list = ds_list_create();
	ds_list_copy(_ans_list, _n);
	if (_ans_list[| 0] == global.math_encoding_map[? "-"]) ds_list_delete(_ans_list, 0);
	return _ans_list;
}

/**
 * @function						self_absolute_value(_self, _is_normalized)
 * @description					Calculates the absolute value of the input value, then reassign to the input.
 * @param {Id.DsList<Real>}	_self - The input value.
 * @param {Bool}					_is_normalized - Check if the input is normalized.
 * @returns {undefined}
 */

function self_absolute_value(_self, _is_normalized = false) {
	if (not _is_normalized) normalize(_self);
	if (_self[| 0] == global.math_encoding_map[? "-"]) ds_list_delete(_self, 0);
}

/**
 * @function						inverse(_n, _is_normalized)
 * @description					Calculates the inverse of the input value.
 *										If the input is negative, returns the positive value.
 *										If the input is positive, returns the negated value.
 * @param {Id.DsList<Real>}	_n - The input value.
 * @param {Bool}					_is_normalized - Check if the input is normalized.
 * @returns {Id.DsList<Real>}	The inverse value.
 */

function inverse(_n, _is_normalized = false) {
	if (not _is_normalized) normalize(_n);
	var _ans_list = ds_list_create();
	ds_list_copy(_ans_list, _n);
	if (_ans_list[| 0] == global.math_encoding_map[? "-"])
		ds_list_delete(_ans_list, 0);
	else if (ds_list_size(_ans_list) > 1 or _ans_list[| 0] != 0)
		ds_list_insert(_ans_list, 0, global.math_encoding_map[? "-"]);
	return _ans_list;
}

/**
 * @function						self_inverse(_self, _is_normalized)
 * @description					Calculates the inverse of the input value, then reassign to it.
 *										If the input is negative, returns the positive value.
 *										If the input is positive, returns the negated value.
 * @param {Id.DsList<Real>}	_self - The input value.
 * @param {Bool}					_is_normalized - Check if the input is normalized.
 * @returns {undefined}	
 */

function self_inverse(_self, _is_normalized = false) {
	if (not _is_normalized) normalize(_self);
	if (_self[| 0] == global.math_encoding_map[? "-"]) ds_list_delete(_self, 0);
	else if (ds_list_size(_self) > 1 or _self[| 0] != 0)	ds_list_insert(_self, 0, global.math_encoding_map[? "-"]);
}

/**
 * @function						shift_decimal(_n, _shift, _is_normalized)
 * @description					Shifts the decimal point of a given number.
 * @param {Id.DsList<Real>}	_n - The input value.
 * @param {Real}					_shift - The number of positions to shift the decimal point.
 *										If positive, shifts to the right; if negative, shifts to 
 *										the left.
 * @param {Bool}					_is_normalized - Check if the input is normalized.
 * @returns {Id.DsList<Real>}
 */

function shift_decimal(_n, _shift, _is_normalized = false) {
	if (not _is_normalized) normalize(_n);
	var _ans_list = ds_list_create();
	ds_list_copy(_ans_list, _n);
	var _dn = ds_list_find_index(_ans_list, global.math_encoding_map[? "."]);
	if (_dn == -1) {
		_dn = ds_list_size(_ans_list);
	} else {
		ds_list_delete(_ans_list, _dn);
	}
	var _decimal_new_pos = _dn + _shift;
	if (_decimal_new_pos > 0 and _decimal_new_pos < ds_list_size(_ans_list)) {
		ds_list_insert(_ans_list, _decimal_new_pos, global.math_encoding_map[? "."]);
	} else if (_decimal_new_pos <= 0) {
		for (; _decimal_new_pos < 0; _decimal_new_pos++)
			ds_list_insert(_ans_list, 0, 0);
		ds_list_insert(_ans_list, 0, global.math_encoding_map[? "."]);
		ds_list_insert(_ans_list, 0, 0);
	} else {
		for (_decimal_new_pos = _decimal_new_pos - ds_list_size(_ans_list); _decimal_new_pos > 0; _decimal_new_pos--)
			ds_list_insert(_ans_list, ds_list_size(_ans_list), 0);
	}
	return _ans_list;
}

/**
 * @function						self_shift_decimal(_self, _shift, _is_normalized)
 * @description					Shifts the decimal point of a given number, then reassign to the input.
 * @param {Id.DsList<Real>}	_self - The input value.
 * @param {Real}					_shift - The number of positions to shift the decimal point.
 *										If positive, shifts to the right; if negative, shifts to 
 *										the left.
 * @param {Bool}					_is_normalized - Check if the input is normalized.
 * @returns {undefined}
 */
 
function self_shift_decimal(_self, _shift, _is_normalized = false) {
	if (not _is_normalized) normalize(_self);
	var _dn = ds_list_find_index(_self, global.math_encoding_map[? "."]);
	if (_dn == -1) _dn = ds_list_size(_self);
	else ds_list_delete(_self, _dn);
	var _decimal_new_pos = _dn + _shift;
	if (_decimal_new_pos > 0 and _decimal_new_pos < ds_list_size(_self))
		ds_list_insert(_self, _decimal_new_pos, global.math_encoding_map[? "."]);
	else if (_decimal_new_pos <= 0) {
		for (; _decimal_new_pos < 0; _decimal_new_pos++)
			ds_list_insert(_self, 0, 0);
		ds_list_insert(_self, 0, global.math_encoding_map[? "."]);
		ds_list_insert(_self, 0, 0);
	} else for (_decimal_new_pos = _decimal_new_pos - ds_list_size(_self); _decimal_new_pos > 0; _decimal_new_pos--)
		ds_list_insert(_self, ds_list_size(_self), 0);
	normalize(_self);
}

/**
 * @function						add(_a, _b, _is_normalized)
 *	@description					Adds two real numbers.
 * @param {Id.DsList<Real>}	_a - The first addend.
 * @param {Id.DsList<Real>}	_b - The second addend.
 * @param {Bool}					_is_normalized - Check if the input is normalized.
 * @returns {Id.DsList<Real>}
 */

function add(_a, _b, _is_normalized = false) {
	if (not _is_normalized) {
		normalize(_a);
		normalize(_b);
		if (_a[| 0] == global.math_encoding_map[? "-"] and _b[| 0] == global.math_encoding_map[? "-"]) {
			ds_list_delete(_a, 0);
			ds_list_delete(_b, 0);
			var _c = add(_a, _b, true);
			ds_list_insert(_a, 0, global.math_encoding_map[? "-"]);
			ds_list_insert(_b, 0, global.math_encoding_map[? "-"]);
			ds_list_insert(_c, 0, global.math_encoding_map[? "-"]);
			return _c;
		}
		if (_a[| 0] == global.math_encoding_map[? "-"]) {
			ds_list_delete(_a, 0);
			var _c = subtract(_b, _a, true);
			ds_list_insert(_a, 0, global.math_encoding_map[? "-"]);
			return _c;
		}
		if (_b[| 0] == global.math_encoding_map[? "-"])  {
			ds_list_delete(_b, 0);
			var _c = subtract(_a, _b, true);
			ds_list_insert(_b, 0, global.math_encoding_map[? "-"]);
			return _c;
		}
	}
	var _dec_pos_a = ds_list_find_index(_a, global.math_encoding_map[? "."]);
	if (_dec_pos_a == -1) _dec_pos_a = ds_list_size(_a);
	var _dec_pos_b = ds_list_find_index(_b, global.math_encoding_map[? "."]);
	if (_dec_pos_b == -1) _dec_pos_b = ds_list_size(_b);
	var _ans_list = ds_list_create();
	var _carry = 0;
	for (
		var _i = max(ds_list_size(_a) - 1 - _dec_pos_a, ds_list_size(_b) - 1 - _dec_pos_b);
		_i >= min(-_dec_pos_a, -_dec_pos_b);
		_i--
	) {
		if (_i == 0) {
			ds_list_add(_ans_list, global.math_encoding_map[? "."]);
			continue;
		}
		var _digit_a = _a[| _dec_pos_a + _i];
		if (is_undefined(_digit_a)) _digit_a = 0;
		var _digit_b = _b[| _dec_pos_b + _i];
		if (is_undefined(_digit_b)) _digit_b = 0;
		var _ds = _digit_a + _digit_b + _carry;
		ds_list_add(_ans_list, _ds % 10);
		_carry = _ds >= 10;
	}
	if (_carry == 1) ds_list_add(_ans_list, 1);
	ds_list_reverse(_ans_list);
	normalize(_ans_list);
	return _ans_list;
}

/**
 * @function				compare(_a, _b, _is_normalized)
 *	@description			Compare two numbers. Return -1 if the first number is 
 *								smaller, 0 if the two number has the same value, 1 if
 *								the first number if bigger.
 * @param {Id.DsList}	_a - The first real number.
 * @param {Id.DsList}	_b - The second real number.
 * @param {Bool}			_is_normalized - Check if the input is normalized.
 * @returns {Real}
 */

function compare(_a, _b, _is_normalized = false) {
	if (not _is_normalized) {
		normalize(_a);
		normalize(_b);
	}
	var _is_both_negative = 0;
	if (_a[| 0] == global.math_encoding_map[? "-"])
		_is_both_negative += 1;
	if (_b[| 0] == global.math_encoding_map[? "-"])
		_is_both_negative += 2;
	switch (_is_both_negative) {
		case 1:
			return -1;
		case 2:
			return 1;
	}
	var _dec_pos_a = ds_list_find_index(_a, global.math_encoding_map[? "."]);
	if (_dec_pos_a == -1) _dec_pos_a = ds_list_size(_a);
	var _dec_pos_b = ds_list_find_index(_b, global.math_encoding_map[? "."]);
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
 * @function				divide(_a, _b, _decimal_precision, _is_normalized)
 *	@description			This function will divide two numbers represented as list with a specified number of digit after the decimal point.
 * @param {Id.DsList}	_a - The dividend.
 * @param {Id.DsList}	_b - The divisor.
 * @param {Real}			_decimal_precision - The desired precision (number of significant digits after the decimal place).
 * @param {Bool}			_is_normalized - Check if the input is normalized.
 * @returns {Id.DsList}
 */

function divide(_a, _b, _decimal_precision = 6, _is_normalized = false) {
	if (not _is_normalized) {
		normalize(_a);
		normalize(_b);
		if (ds_list_size(_b) == 1 and _b[| 0] == 0) {
			var _c = ds_list_create();
			ds_list_add(_c, -1);
			return _c;
		}
		if (_a[| 0] == global.math_encoding_map[? "-"] && _b[| 0] == global.math_encoding_map[? "-"]) {
			ds_list_delete(_a, 0);
			ds_list_delete(_b, 0);
			var _c = divide(_a, _b, _decimal_precision, true);
			ds_list_insert(_a, 0, global.math_encoding_map[? "-"]);
			ds_list_insert(_b, 0, global.math_encoding_map[? "-"]);
			return _c;
		}
		if (_a[| 0] == global.math_encoding_map[? "-"]) {
			ds_list_delete(_a, 0);
			var _c = divide(_a, _b, _decimal_precision, true);
			ds_list_insert(_a, 0, global.math_encoding_map[? "-"]);
			ds_list_insert(_c, 0, global.math_encoding_map[? "-"]);
			return _c;
		}
		if (_b[| 0] == global.math_encoding_map[? "-"]) {
			ds_list_delete(_b, 0);
			var _c = divide(_a, _b, _decimal_precision, true);
			ds_list_insert(_b, 0, global.math_encoding_map[? "-"]);
			ds_list_insert(_c, 0, global.math_encoding_map[? "-"]);
			return _c;
		}
	}
	var _dec_shift = 0;
	var _dec_pos_a = ds_list_find_index(_a, global.math_encoding_map[? "."]);
	if (_dec_pos_a != -1) {
		_dec_shift = ds_list_size(_a) - 1 - _dec_pos_a;
		ds_list_delete(_a, _dec_pos_a);
	}
	var _dec_pos_b = ds_list_find_index(_b, global.math_encoding_map[? "."]);
	if (_dec_pos_b != -1) {
		_dec_shift -= ds_list_size(_b) - 1 - _dec_pos_b;
		ds_list_delete(_b, _dec_pos_b);
	}
	var _ans_list;
	if (_dec_shift < _decimal_precision) {
		var _shift_a = _decimal_precision - _dec_shift;
		self_shift_decimal(_a, _shift_a);
		_ans_list = int_divide_v2(_a, _b);
		self_shift_decimal(_a, -_shift_a, true);
	} else if (_dec_shift > _decimal_precision) {
		var _c = ds_list_create();
		for (var _i = 0; _i < ds_list_size(_a) - _dec_shift + _decimal_precision; _i++)
			ds_list_add(_c, _a[| _i]);
		_ans_list = int_divide_v2(_c, _b);
		ds_list_destroy(_c);
	} else {
		_ans_list = int_divide_v2(_a, _b);
	}
	_dec_shift = _decimal_precision;

	ds_list_insert(_a, _dec_pos_a, global.math_encoding_map[? "."]);
	ds_list_insert(_b, _dec_pos_b, global.math_encoding_map[? "."]);
	self_shift_decimal(_ans_list, -_dec_shift, true);
	return _ans_list;
}

/**
 * @function				int_divide_v2(_a, _b)
 *	@description			This function will divide two integers and return the truncated integer quotient.
 * @param {Id.DsList}	_a - The dividend.
 * @param {Id.DsList}	_b - The divisor.
 * @returns {Id.DsList}
 */

function int_divide_v2(_a, _b) {
	var _ans_list = ds_list_create();
	if (compare(_a, _b, true) == -1) {
		ds_list_add(_ans_list, 0);
		return _ans_list;
	}
	var _da = ds_list_size(_a);
	var _db = ds_list_size(_b);
	var _bb = ds_list_size(_b) > 1 ? _b[| 0] * 10 + _b[| 1] : _b[| 0];
	var _leftover_a = ds_list_create();	
	for (var _i = 0; _i < _da; _i++) {
		ds_list_add(_leftover_a, _a[| _i]);
		if (ds_list_size(_leftover_a) < ds_list_size(_b)) {
			ds_list_add(_ans_list, 0);
			continue;
		}
		var _ba;
		if (ds_list_size(_leftover_a) > ds_list_size(_b))
			_ba = (
				ds_list_size(_leftover_a) > 2
				? _leftover_a[| 0] * 100 + _leftover_a[| 1] * 10 + _leftover_a[| 2]
				: _leftover_a[| 0] * 10 + _leftover_a[| 1]
			);
		else
			_ba = ds_list_size(_leftover_a) > 1 ? _leftover_a[| 0] * 10 + _leftover_a[| 1] : _leftover_a[| 0];
		var _c = ds_list_create();
		ds_list_add(_c, _ba div _bb);
		var _d = multiply(_c, _b, true);
		if (compare(_d, _leftover_a) == 1) {
			var _f = subtract(_d, _b, true);
			ds_list_destroy(_d);
			_d = _f;
			_c[| 0] = _c[| 0] - 1;
		}
		ds_list_add(_ans_list, _c[| 0]);
		ds_list_destroy(_c);
		_c = subtract(_leftover_a, _d, true);
		ds_list_destroy_multiple(_leftover_a, _d);
		_leftover_a = _c;
	}
	ds_list_destroy(_leftover_a);
	return _ans_list;
}

/**
 * @function				int_multiply_v1(_a, _b)
 *	@description			Multiply two integers (Long Multiplication).
 * @param {Id.DsList}	_a - The multiplier.
 * @param {Id.DsList}	_b - The multiplicand.
 * @returns {Id.DsList}
 */

function int_multiply_v1(_a, _b) {
	var _ans_list = ds_list_create();
	var _carry = 0;
	for (var _i = ds_list_size(_b) - 1; _i >= 0; _i--) {
		for (var _j = ds_list_size(_a) - 1; _j >= 0; _j--) {
			var _curr_prod = _a[| _j] * _b[| _i] + _carry;
			var _curr_id = ds_list_size(_a) + ds_list_size(_b) - 2 - _i - _j;
			if (_curr_id >= ds_list_size(_ans_list))
				ds_list_add(_ans_list, _curr_prod % 10);
			else {
				_curr_prod += _ans_list[| _curr_id];
				_ans_list[| _curr_id] = _curr_prod % 10;
			}
			_carry = _curr_prod div 10;
		}
		if (_carry > 0) {
			ds_list_add(_ans_list, _carry);
			_carry = 0;
		}
	}
	ds_list_reverse(_ans_list);
	return _ans_list;
}

/**
 * @function				int_multiply_v2(_a, _b)
 *	@description			Multiply two integers (Karatsuba).
 * @param {Id.DsList}	_a - The multiplier.
 * @param {Id.DsList}	_b - The multiplicand.
 * @returns {Id.DsList}
 */

function int_multiply_v2(_a, _b) {
	if (ds_list_size(_a) == 1 or ds_list_size(_b) == 1) {
		return int_multiply_v1(_a, _b);
	}
	var _bm_shift = ceil(min(ds_list_size(_a), ds_list_size(_b)) / 2);
	var _a0 = ds_list_create();
	var _a1 = ds_list_create();
	for (var _i = 0; _i < ds_list_size(_a) - _bm_shift; _i++)
		ds_list_add(_a0, _a[| _i]);
	for (var _i = ds_list_size(_a) - _bm_shift; _i < ds_list_size(_a); _i++)
		ds_list_add(_a1, _a[| _i]);
	var _b0 = ds_list_create();
	var _b1 = ds_list_create();
	for (var _i = 0; _i < ds_list_size(_b) - _bm_shift; _i++)
		ds_list_add(_b0, _b[| _i]);
	for (var _i = ds_list_size(_b) - _bm_shift; _i < ds_list_size(_b); _i++)
		ds_list_add(_b1, _b[| _i]);
	var _z2 = int_multiply_v2(_a1, _b1);
	var _z0 = int_multiply_v2(_a0, _b0);
	var _w1 = add(_a0, _a1, true);
	var _w2 = add(_b0, _b1, true);
	ds_list_destroy(_a0);
	ds_list_destroy(_a1);
	ds_list_destroy(_b0);
	ds_list_destroy(_b1);
	var _w3 = int_multiply_v2(_w1, _w2);
	ds_list_destroy(_w1);
	ds_list_destroy(_w2);
	_w1 = subtract(_w3, _z2, true);
	ds_list_destroy(_w3);
	var _z1 = subtract(_w1, _z0, true);
	ds_list_destroy(_w1);
	self_shift_decimal(_z0, 2 * _bm_shift);
	self_shift_decimal(_z1, _bm_shift);
	var _w1 = add(_z2, _z1, true);
	ds_list_destroy(_z2);
	ds_list_destroy(_z1);
	var _ans_list = add(_w1, _z0, true);
	ds_list_destroy(_w1);
	ds_list_destroy(_z0);
	return _ans_list;
}

/**
 * @function				multiply(_a, _b, _is_normalized)
 *	@description			Multiplies two real numbers represented as string.
 * @param {Id.DsList}	_a - The multiplicand.
 * @param {Id.DsList}	_b - The multiplier.
 * @param {Bool}			_is_normalized - Check if the input is normalized.
 * @returns {Id.DsList}
 */
 
function multiply(_a, _b, _is_normalized=false) {
	if (not _is_normalized) {
		normalize(_a);
		normalize(_b);
		if (_a[| 0] == global.math_encoding_map[? "-"] and _b[| 0] == global.math_encoding_map[? "-"]) {
			ds_list_delete(_a, 0);
			ds_list_delete(_b, 0);
			var _c = multiply(_a, _b, true);
			ds_list_insert(_a, 0, global.math_encoding_map[? "-"]);
			ds_list_insert(_b, 0, global.math_encoding_map[? "-"]);
			return _c;
		}
		if (_a[| 0] == global.math_encoding_map[? "-"]) {
			ds_list_delete(_a, 0);
			var _c = multiply(_a, _b, true);
			ds_list_insert(_a, 0, global.math_encoding_map[? "-"]);
			ds_list_insert(_c, 0, global.math_encoding_map[? "-"]);
			return _c;
		}
		if (_b[| 0] == global.math_encoding_map[? "-"]) {
			ds_list_delete(_b, 0);
			var _c = multiply(_a, _b, true);
			ds_list_insert(_b, 0, global.math_encoding_map[? "-"]);
			ds_list_insert(_c, 0, global.math_encoding_map[? "-"]);
			return _c;
		}
	}
	var _dec_shift = 0;
	var _dec_pos_a = ds_list_find_index(_a, global.math_encoding_map[? "."]);
	if (_dec_pos_a != -1) {
		_dec_shift = ds_list_size(_a) - 1 - _dec_pos_a;
		ds_list_delete(_a, _dec_pos_a);
	}
	var _dec_pos_b = ds_list_find_index(_b, global.math_encoding_map[? "."]);
	if (_dec_pos_b != -1) {
		_dec_shift += ds_list_size(_b) - 1 - _dec_pos_b;
		ds_list_delete(_b, _dec_pos_b);
	}
	var _ans_list = int_multiply_v1(_a, _b);
	if (_dec_shift > 0) {
		self_shift_decimal(_ans_list, -_dec_shift, true);
		if (_dec_pos_a != -1)
			ds_list_insert(_a, _dec_pos_a, global.math_encoding_map[? "."]);
		if (_dec_pos_b != -1)
			ds_list_insert(_b, _dec_pos_b, global.math_encoding_map[? "."]);
	}
	normalize(_ans_list);
	return _ans_list;
}

/**
 * @function				subtract(_a, _b, _is_normalized)
 * @description			Subtract two real numbers.
 * @param {Id.DsList}	_a - The minuend.
 * @param {Id.DsList}	_b - The subtrahend.
 * @param {Bool}			_is_normalized - Check if the input is normalized.
 * @returns {Id.DsList}
 */

function subtract(_a, _b, _is_normalized=false) {
	if (not _is_normalized) {
		normalize(_a);
		normalize(_b);
		if (_a[| 0] == global.math_encoding_map[? "-"] and _b[| 0] == global.math_encoding_map[? "-"]) {
			ds_list_delete(_b, 0);
			ds_list_delete(_a, 0);
			var _c = subtract(_b, _a, true);
			ds_list_insert(_a, 0, global.math_encoding_map[? "-"]);
			ds_list_insert(_b, 0, global.math_encoding_map[? "-"]);
			return _c;
		}
		if (_a[| 0] == global.math_encoding_map[? "-"]) {
			ds_list_delete(_a, 0);
			var _c = add(_a, _b, true);
			ds_list_insert(_a, 0, global.math_encoding_map[? "-"]);
			ds_list_insert(_c, 0, global.math_encoding_map[? "-"]);
			return _c;
		}
		if (_b[| 0] == global.math_encoding_map[? "-"]) {
			ds_list_delete(_b, 0);
			var _c = add(_a, _b, true);
			ds_list_insert(_b, 0, global.math_encoding_map[? "-"]);
			return _c;
		}
	}
	var _dec_pos_a = ds_list_find_index(_a, global.math_encoding_map[? "."]);
	if (_dec_pos_a == -1) _dec_pos_a = ds_list_size(_a);
	var _dec_pos_b = ds_list_find_index(_b, global.math_encoding_map[? "."]);
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
				ds_list_add(_ans_list, global.math_encoding_map[? "."]);
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
		ds_list_add(_ans_list, global.math_encoding_map[? "-"]);
		ds_list_reverse(_ans_list);
	} else {
		var _borrow = 0;
		for (
			var _i = max(ds_list_size(_a) - 1 - _dec_pos_a, ds_list_size(_b) - 1 - _dec_pos_b);
			_i >= min(-_dec_pos_a, -_dec_pos_b);
			_i--
		) {
			if (_i == 0) {
				ds_list_add(_ans_list, global.math_encoding_map[? "."]);
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
 * @function				evaluate_equation(_a, _b, _is_normalized)
 * @description			This function will subtract two real numbers represented as Id.DsList.
 * @param {Id.DsList}	_equation - The equation represented in a list.
 * @returns {Id.DsList}
 */

function evaluate_equation(_equation) {
	var _operator_stack = ds_stack_create();
	var _number_stack = ds_stack_create();
	var _ans_list;

	for (var _i = 0; _i < ds_list_size(_equation); _i++) {
		var _current_component = _equation[| _i];
		if (_current_component[| 0] <= 11) {
			var _current_number = ds_list_create();
			ds_list_copy(_current_number, _current_component);
			ds_stack_push(_number_stack, _current_number);
		} else if (_current_component[| 0] == global.math_encoding_map[? "("]) {
			ds_stack_push(_operator_stack, global.math_encoding_map[? "("]);
		} else if (_current_component[| 0] == global.math_encoding_map[? ")"]) {
			while (typeof(ds_stack_top(_operator_stack)) == "ref") {
				var _executing_operator = ds_stack_pop(_operator_stack);
				// Low arguments error check
				if (ds_stack_size(_number_stack) < _executing_operator[? "input_count"]) {
					stack_full_remove(_number_stack, _operator_stack);
					_ans_list = ds_list_create();
					ds_list_add(_ans_list, -1);
					return _ans_list;
				}
				if (_executing_operator[? "input_count"] == 2) {
					var _b = ds_stack_pop(_number_stack);
					var _a = ds_stack_pop(_number_stack);
					var _c = _executing_operator[? "function"](_a, _b);
					ds_list_destroy(_a);
					ds_list_destroy(_b);
					ds_stack_push(_number_stack, _c);
				}
			}
			ds_stack_pop(_operator_stack);
		} else {
			var _current_operator = global.operator_map[? _current_component[| 0]];
			while (
				!ds_stack_empty(_operator_stack) and typeof(ds_stack_top(_operator_stack)) == "ref" and 
				ds_stack_top(_operator_stack)[? "priority"] >= _current_operator[? "priority"]
			) {
				
				var _executing_operator = ds_stack_pop(_operator_stack);
				// Low arguments error check
				if (ds_stack_size(_number_stack) < _executing_operator[? "input_count"]) {
					stack_full_remove(_number_stack, _operator_stack);
					_ans_list = ds_list_create();
					ds_list_add(_ans_list, -1);
					return _ans_list;
				}
				if (_executing_operator[? "input_count"] == 2) {
					var _b = ds_stack_pop(_number_stack);
					var _a = ds_stack_pop(_number_stack);
					var _c = _executing_operator[? "function"](_a, _b);
					ds_list_destroy(_a);
					ds_list_destroy(_b);
					if (_c[| 0] == -1) {
						stack_full_remove(_number_stack, _operator_stack);
						_ans_list = ds_list_create();
						ds_list_add(_ans_list, -1);
						return _ans_list;
					}
					ds_stack_push(_number_stack, _c);
				}
			}
			ds_stack_push(_operator_stack, _current_operator);
		}
	}
	while (!ds_stack_empty(_operator_stack)) {
		var _executing_operator = ds_stack_pop(_operator_stack);
		if (typeof(ds_stack_top(_operator_stack)) == "number"
			or ds_stack_size(_number_stack) < _executing_operator[? "input_count"]) {
			stack_full_remove(_number_stack, _operator_stack);
			_ans_list = ds_list_create();
			ds_list_add(_ans_list, -1);
			return _ans_list;
		}
		if (_executing_operator[? "input_count"] == 2) {
			var _b = ds_stack_pop(_number_stack);
			var _a = ds_stack_pop(_number_stack);
			var _c = _executing_operator[? "function"](_a, _b);
			ds_list_destroy(_a);
			ds_list_destroy(_b);
			if (_c[| 0] == -1) {
				stack_full_remove(_number_stack, _operator_stack);
				_ans_list = ds_list_create();
				ds_list_add(_ans_list, -1);
				return _ans_list;
			}
			ds_stack_push(_number_stack, _c);
		}
	}
	_ans_list = ds_stack_pop(_number_stack);

	stack_full_remove(_number_stack, _operator_stack);
	return _ans_list;
}