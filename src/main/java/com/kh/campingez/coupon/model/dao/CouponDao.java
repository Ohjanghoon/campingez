package com.kh.campingez.coupon.model.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.campingez.coupon.model.dto.Coupon;

@Mapper
public interface CouponDao {

	@Select("select * from coupon where coupon_code = #{coupon_code}")
	boolean findByCoupon(String couponCode);
	
	@Insert("insert into coupon values(#{couponCode}, #{couponName}, #{couponDiscount}, #{couponStartday}, #{couponEndday}, default)")
	int insertCoupon(Coupon coupon);
}
