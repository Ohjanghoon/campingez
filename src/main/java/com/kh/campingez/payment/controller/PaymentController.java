package com.kh.campingez.payment.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.payment.model.service.PaymentService;

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
	public ResponseEntity<?> updateReservation(@RequestParam String resNo) {
		log.debug("resNo = {}", resNo);
		
		int result = paymentService.updateReservation(resNo);
		return ResponseEntity.ok().build();
	}
}
