package com.kh.campingez.coupon.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.kh.campingez.coupon.model.dto.Coupon;
import com.kh.campingez.coupon.model.dto.UserCoupon;

@Mapper
public interface CouponDao {

	@Insert("insert into coupon values(#{couponCode}, #{couponName}, #{couponDiscount}, #{couponStartday}, #{couponEndday}, default)")
	int insertCoupon(Coupon coupon);

	@Select("select * from coupon where coupon_endday >= current_date")
	List<Coupon> findCoupon();

	@Select("select * from coupon where coupon_code = #{couponCode}")
	Coupon findCouponByCode(String couponeCode);

	@Insert("insert into user_coupon values(#{userId}, #{couponCode}, null, default)")
	int couponDownload(Map<Object, String> param);

	@Select("select * from user_coupon where user_id = #{userId} and coupon_code = #{couponCode}")
	UserCoupon findCouponByUser(Map<Object, String> param);

	@Update("update coupon set coupon_down_count = coupon_down_count+1 where coupon_code = #{couponCode}")
	int updateDownCount(Map<Object, String> param);
}
