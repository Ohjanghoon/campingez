package com.kh.campingez.coupon.model.service;

import com.kh.campingez.coupon.model.dto.Coupon;

public interface CouponService {

	boolean findByCoupon(String couponCode);

	int insertCoupon(Coupon coupon);
}
