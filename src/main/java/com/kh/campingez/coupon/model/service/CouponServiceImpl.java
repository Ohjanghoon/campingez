package com.kh.campingez.coupon.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.coupon.model.dao.CouponDao;
import com.kh.campingez.coupon.model.dto.Coupon;

@Service
public class CouponServiceImpl implements CouponService {
	
	@Autowired
	private CouponDao couponDao;
	

	@Override
	public boolean findByCoupon(String couponCode) {
		return couponDao.findByCoupon(couponCode);
	}
	
	@Override
	public int insertCoupon(Coupon coupon) {
		return couponDao.insertCoupon(coupon);
	}
}
