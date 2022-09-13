package com.kh.campingez.coupon.model.dto;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class UserCoupon extends UserCouponEntity{
	
	private int couponCount;
	private List<Coupon> coupons = new ArrayList<>();

	public UserCoupon(String userId, String couponCode, LocalDate couponUsedate, LocalDate couponDowndate) {
		super(userId, couponCode, couponUsedate, couponDowndate);
		// TODO Auto-generated constructor stub
	}
	
}
