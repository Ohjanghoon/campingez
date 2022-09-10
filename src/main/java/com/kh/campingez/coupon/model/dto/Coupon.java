package com.kh.campingez.coupon.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Coupon {
	private String couponCode;
	private String couponName;
	private int couponDiscount;
	private LocalDate couponStartday;
	private LocalDate couponEndday;
	private int couponDownCount;
	//김승환 전용 유저 쿠폰컬럼
	private LocalDate couponUsedate;
}
