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
import com.kh.campingez.reservation.model.dto.Reservation;
import com.kh.campingez.reservation.model.service.ReservationService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/reservation")

public class ReservationController {
	
	@Autowired
	private ReservationService reservationService;
	
	@GetMapping("/campList")
	public void campList() {}
	
	@PostMapping("/campList")
	public ResponseEntity<?> campList(@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkin, 
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkout) {
		Map<String, Object> param = new HashMap<>();
		param.put("checkin", checkin);
		param.put("checkout", checkout);
		log.debug("check = {}, {}", checkin, checkout);
		List<Camp> camp = reservationService.campList(param);
		
		log.debug("camp = {}", camp);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(camp);
	}
	
	@PostMapping("/campZoneInfo")
	public ResponseEntity<?> campZoneInfo(@RequestParam String campId) {
		CampZone campZone = reservationService.campZoneInfo(campId);
		
		log.debug("campZone = {}", campZone);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(campZone);
	}
	
	@PostMapping("/reservation")
	public String insertReservation(Reservation reservation, RedirectAttributes redirectAttr) {
//		int result = reservationService.insertReservation(reservation);
		redirectAttr.addFlashAttribute("msg", "예약을 완료하였습니다.");
		return "redirect:/";
	}
}
