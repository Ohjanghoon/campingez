package com.kh.campingez.coupon.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.coupon.model.dao.CouponDao;
import com.kh.campingez.coupon.model.dto.Coupon;
import com.kh.campingez.coupon.model.dto.UserCoupon;

@Service
public class CouponServiceImpl implements CouponService {
	
	@Autowired
	private CouponDao couponDao;
	
	
	@Override
	public int insertCoupon(Coupon coupon) {
		return couponDao.insertCoupon(coupon);
	}
	
	@Override
	public List<Coupon> findCoupon() {
		return couponDao.findCoupon();
	}
	
	@Override
	public Coupon findCouponByCode(String couponeCode) {
		return couponDao.findCouponByCode(couponeCode);
	}
	
	@Override
	public int couponDownload(Map<Object, String> param) {
		// 유저 쿠폰 업데이트
		int result = couponDao.couponDownload(param);
		// 쿠폰 다운 횟수 + 1
		result = couponDao.updateDownCount(param);
		
		return result;
	}
	
	@Override
	public UserCoupon findCouponByUser(Map<Object, String> param) {
		return couponDao.findCouponByUser(param);
	}
	
	@Override
	public List<UserCoupon> findCouponbyUserId(String userId) {
		return couponDao.findCouponbyUserId(userId);
	}
}
