package com.kh.campingez.coupon.controller;

import java.time.LocalDate;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.coupon.model.dto.Coupon;
import com.kh.campingez.coupon.model.service.CouponService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/coupon")
public class CouponController {

	@Autowired
	private CouponService couponService;
	
	
	@GetMapping("/insertCoupon")
	public void Insertcoupon() {}
	
	
	@PostMapping("/insertCoupon")
	public String Insertcoupon(@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startday, @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endday,
			Coupon coupon, RedirectAttributes redirectAttr) {
		String couponCode = makeCouponCode() + "-" + makeCouponCode() + "-" + makeCouponCode();
		coupon.setCouponCode(couponCode);
		coupon.setCouponStartday(startday);
		coupon.setCouponEndday(endday);
		int result = couponService.insertCoupon(coupon);
		
		// 실패시 리턴
		if(result == 0) {
			return couponCode;
		}
		
		redirectAttr.addFlashAttribute("msg", "쿠폰을 등록하였습니다.");
		return "redirect:/notice/list";
	}
	
	/**
	 * 대문자/숫자 조합
	 */
	private String makeCouponCode() {
		Random random = new Random();
		StringBuilder sb = new StringBuilder();
		final int len = 4;
		for(int i = 0; i < len; i++) {			
			if(random.nextBoolean()) {
				// 대문자
				sb.append((char) (random.nextInt(26) + 'A'));
			}
			else {
				// 숫자
				sb.append(random.nextInt(10));
			}
		}
		return sb.toString();
	}
}
