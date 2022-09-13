package com.kh.campingez.coupon.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserCouponEntity {

	private String userId;
	private String couponCode;
	private LocalDate couponUsedate;
	private LocalDate couponDowndate;
}
