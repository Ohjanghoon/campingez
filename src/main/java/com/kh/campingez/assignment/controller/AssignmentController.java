package com.kh.campingez.assignment.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.assignment.model.service.AssignmentService;
import com.kh.campingez.reservation.model.dto.Reservation;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/assignment")
public class AssignmentController {

	@Autowired
	AssignmentService assignmentService;
	
	@GetMapping("/assignmentList.do")
	public void selectAssignmentList(Model model) {
		List<Assignment> list = assignmentService.selectAssignmentList();
		log.debug("list = {}", list);
		
		model.addAttribute("assignmentList", list);
		
	}
	
	@PostMapping("/assignmentEnroll.do")
	public void assignmentEnroll(Model model, @RequestParam String userId) {
		log.debug("userId = {}", userId);
		
		List<Reservation> list = assignmentService.selectReservationList(userId);
		log.debug("reservationList = {}", list);
		
		model.addAttribute("reservationList", list);
	}
}
