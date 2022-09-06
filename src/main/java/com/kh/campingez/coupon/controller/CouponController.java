package com.kh.campingez.coupon.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.coupon.model.dto.Coupon;
import com.kh.campingez.coupon.model.dto.UserCoupon;
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
	
	@PostMapping("/couponlist")
	public ResponseEntity<?> findCoupon(){
		List<Coupon> couponlist = couponService.findCoupon();
		log.debug("couponlist = {}", couponlist);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(couponlist);
	}
	
	@PostMapping("/couponInfo")
	public ResponseEntity<?> findCouponByCode(@RequestBody String couponeCode){
		couponeCode = couponeCode.substring(0, couponeCode.length() -1);
		log.debug("couponeCode = {}", couponeCode);
		Coupon coupon = couponService.findCouponByCode(couponeCode);
		log.debug("coupon = {}", coupon);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(coupon);
	}
	
	@PostMapping("/couponDown")
	public ResponseEntity<?> couponDownload(@RequestParam String couponCode, @RequestParam String userId){
		// 파람
		Map<Object, String > param = new HashMap<>();
		param.put("couponCode", couponCode);
		param.put("userId", userId);

		// 메세지
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		
		// 유저 쿠폰 검사
		UserCoupon userCoupon = couponService.findCouponByUser(param);
		
		if(userCoupon != null) {
			map.put("resultMessage", "이미 발급받은 쿠폰입니다.");
			return ResponseEntity.ok().body(map);
		}
		
		int result = couponService.couponDownload(param);
		map.put("resultMessage", "쿠폰을 발급받았습니다.");
		return ResponseEntity.ok().body(map);
	}
	
}
