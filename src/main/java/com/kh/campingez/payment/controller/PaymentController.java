package com.kh.campingez.payment.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.campingez.alarm.model.service.AlarmService;
import com.kh.campingez.payment.model.service.PaymentService;
import com.kh.campingez.user.model.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/payment")
public class PaymentController {

	@Autowired
	PaymentService paymentService;
	
	@Autowired
	AlarmService alarmService;
	
	@Autowired
	UserService userService;
	
	@GetMapping("/payment.do")
	public void payment() {}
	
	@PostMapping("/paymentSuccess.do")
	public ResponseEntity<?> updateReservation(
			@RequestParam String resNo, @RequestParam String resState,
			@RequestParam(required = false) String assignNo,
			@RequestParam String userId, @RequestParam int resPrice) {
		
		log.debug("resNo = {}, resState = {}", resNo, resState);
		log.debug("assignNo = {}", assignNo);
		log.debug("resPrice = {}", resPrice);
		
		int result = 0;
		int point = (int) (resPrice * 0.1);
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("point", point);
		
		switch(resState) {
			case "결제대기" : result = paymentService.updateReservation(resNo); 
							result =userService.giveToPoint(map); break; 
			case "양도결제대기" : 
				result = paymentService.updateAssignReservation(resNo, assignNo); 
				alarmService.assignSuccessAlarm(assignNo);
				result = userService.giveToPoint(map);
				break;
		}
		
		
		return ResponseEntity.ok().build();
	}
}
