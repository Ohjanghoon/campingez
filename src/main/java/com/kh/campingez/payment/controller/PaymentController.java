package com.kh.campingez.payment.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.campingez.payment.model.service.PaymentService;
import com.kh.campingez.reservation.model.dto.Reservation;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/payment")
public class PaymentController {

	@Autowired
	PaymentService paymentService;
	
	@GetMapping("/payment.do")
	public void payment() {}
	
	@PostMapping("/paymentSuccess.do")
	public ResponseEntity<?> updateReservation(
			@RequestParam String resNo, @RequestParam String resState,
			@RequestParam(required = false) String assignNo) {
		
		log.debug("resNo = {}, resState = {}", resNo, resState);
		log.debug("assignNo = {}", assignNo);
		
		int result = 0;
		switch(resState) {
			case "결제대기" : result = paymentService.updateReservation(resNo); break; 
			case "양도결제대기" : result = paymentService.updateAssignReservation(resNo, assignNo); break;
		}
		
		
		return ResponseEntity.ok().build();
	}
}
