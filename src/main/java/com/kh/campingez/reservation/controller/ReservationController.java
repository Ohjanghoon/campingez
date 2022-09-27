package com.kh.campingez.reservation.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.campzone.model.dto.Camp;
import com.kh.campingez.campzone.model.dto.CampZone;
import com.kh.campingez.coupon.model.dto.UserCoupon;
import com.kh.campingez.coupon.model.service.CouponService;
import com.kh.campingez.reservation.model.dto.Reservation;
import com.kh.campingez.reservation.model.service.ReservationService;
import com.kh.campingez.review.model.dto.Review;
import com.kh.campingez.review.model.service.ReviewService;
import com.kh.campingez.user.model.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/reservation")
public class ReservationController {
	
	@Autowired
	private ReservationService reservationService;
	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	CouponService couponService;
	
	@Autowired
	UserService userService;
	
	@GetMapping("/list")
	public void campList() {}
	
	@PostMapping("/list")
	public ResponseEntity<?> campList(@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkin, 
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkout, @RequestParam String userId) {
		Map<String, Object> param = new HashMap<>();
		param.put("checkin", checkin);
		param.put("checkout", checkout);
		log.debug("check = {}, {}", checkin, checkout);
		List<Camp> camp = reservationService.campList(param);
		
		List<UserCoupon> userCoupons = couponService.findCouponbyUserId(userId);
		
		log.debug("userCoupon = {}", userCoupons);
		log.debug("camp = {}", camp);
		Map<String, Object> map = new HashMap<>();
		map.put("camp", camp);
		map.put("userCoupon", userCoupons);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(map);
	}
	
	@PostMapping("/campZoneInfo")
	public ResponseEntity<?> campZoneInfo(@RequestParam(required=false) String campId) {
		CampZone campZone = reservationService.campZoneInfo(campId);
		
		log.debug("campZone = {}", campZone);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(campZone);
	}
	
	@PostMapping("/insertReservation")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public String insertReservation(@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkin, 
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkout, @RequestParam int point, 
			@RequestParam String couponCode, Reservation reservation, RedirectAttributes redirectAttr) {
		
		reservation.setResCheckin(checkin);
		reservation.setResCheckout(checkout);
		log.debug("couponCode = {}", couponCode);
		log.debug("point = {}", point);
		
		// 할인 결제시
		if(couponCode != "" || point > 0) {
			
			Map<Object, Object> map = new HashMap<>();
			map.put("userId", reservation.getUserId());
			map.put("point", point);
			
			int resultPrice = reservation.getResPrice();
			int effect = 0;
			
			if(couponCode != "") {
				int dc = couponCode.indexOf('@');
				Double halin = ((double)(Integer.parseInt(couponCode.substring(0, dc)))/100);
				resultPrice = (int) (resultPrice - (resultPrice * halin));
				reservation.setResPrice(resultPrice);
				couponCode = couponCode.substring(dc+1, couponCode.length());
				map.put("couponCode", couponCode);
				effect = userService.userUseCoupon(map);
			}
			if(point > 0) {
				resultPrice = resultPrice - point;
				reservation.setResPrice(resultPrice);
				effect = userService.userUsePoint(map);
			}
			
			// 예약 
			Reservation result = reservationService.insertReservation(reservation);
			redirectAttr.addFlashAttribute("payRes", result);
		}
		
		// 그냥 일반 결제시
		else{
			Reservation result = reservationService.insertReservation(reservation);
			redirectAttr.addFlashAttribute("payRes", result);
		}
		
		log.debug("reservation = {}", reservation);
		return "redirect:/payment/payment.do";
	}
	
	@GetMapping("/intro")
	public void intro() {}

	@PostMapping("/bestReviewByCampzone")
	public ResponseEntity<?> BestReviewByCampzone(@RequestParam String campZone){
		campZone = "%" + campZone + "%";
		log.debug("campZone = {}", campZone);
		Review review = reviewService.bestReviewByCampzone(campZone);
		log.debug("review = {}", review);
		if(review == null ) {
			return ResponseEntity.ok().body("review no");
		}
		else {
			return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(review);
		}
	}
	
//	@GetMapping("/campZoneDayCount")
//	public ResponseEntity<?> CampZoneDayCount(){
//		Map<String, Object> param = new HashMap<>();
//		
//		List<CampZoneCount> countCampZone = reviewService.campZoneDayCount();
//		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(countCampZone);
//	}
	
	@GetMapping("/find")
	public void findReservation() {}
	
	@PostMapping("/find")
	public String findReservationByName(@RequestParam String resUsername, @RequestParam String resPhone, RedirectAttributes redirectAttr) {
		
		Map<Object, String> param = new HashMap<>();
		param.put("resUsername", resUsername);
		param.put("resPhone", resPhone);
		List<Reservation> reservations = reservationService.findReservationByName(param);
		log.debug("reservations = {}", reservations);
		redirectAttr.addFlashAttribute("reservations", reservations);
		
		return "redirect:/reservation/result.do";
	}
	
	@GetMapping("result.do")
	public void findReservationResult() {}
	
}
