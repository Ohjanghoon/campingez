package com.kh.campingez.coupon.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.coupon.model.dto.Coupon;
import com.kh.campingez.coupon.model.dto.UserCoupon;

public interface CouponService {

	List<Coupon> findCoupon();

	int insertCoupon(Coupon coupon);

	Coupon findCouponByCode(String couponeCode);

	int couponDownload(Map<Object, String> param);

	UserCoupon findCouponByUser(Map<Object, String> param);

	List<UserCoupon> findCouponbyUserId(String userId);
}
