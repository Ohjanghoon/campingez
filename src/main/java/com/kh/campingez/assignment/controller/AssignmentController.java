package com.kh.campingez.assignment.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.assignment.model.dto.AssignmentEntity;
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
	
	@PostMapping("/assignmentForm.do")
	public void assignmentEnroll(Model model, @RequestParam String userId) {
		//log.debug("userId = {}", userId);
		
		List<Reservation> list = assignmentService.selectReservationList(userId);
		//log.debug("reservationList = {}", list);
		
		model.addAttribute("reservationList", list);
	}
	
	@PostMapping("/resInfo.do")
	public ResponseEntity<?> selectResInfo(@RequestParam String resNo) {
		//log.debug("resNo = {}", resNo);
		
		Reservation resInfo = assignmentService.selectResInfo(resNo);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(resInfo);
	}
	
	@PostMapping("/assignmentEnroll.do")
	public String insertAssignment(AssignmentEntity assignment, RedirectAttributes redirectAttr) {
//		log.debug("assignment = {}", assignment);
		
		int result = assignmentService.insertAssignment(assignment);
		redirectAttr.addFlashAttribute("msg", "양도 등록되었습니다.");
		return "redirect:/assignment/assignmentList.do";
	}
	
	@GetMapping("/assignmentDetail.do")
	public void assignmentDetail(@RequestParam String assignNo, Model model) {
//		log.debug("assignNo = {}", assignNo);
		
		Assignment assign = assignmentService.assignmentDetail(assignNo);
//		log.debug("assign", assign);
		
		model.addAttribute("assign", assign);
	}
	
	@PostMapping("/assignmentApplyForm.do")
	public void assignmentApply(@RequestParam String assignNo, Model model) {
//		log.debug("assignNo = {}", assignNo);
		
		Assignment assign = assignmentService.assignmentDetail(assignNo);
//		log.debug("assign = {}", assign);
		
		model.addAttribute("assign", assign);
	}
	
	@PostMapping("/assignmentApply.do")
	public String assignmentApply(
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate resCheckin,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate resCheckout,
			Reservation reservation) {
		
		reservation.setResCheckin(resCheckin);
		reservation.setResCheckin(resCheckout);
		log.debug("reservation = {}", reservation);
		
		return null;
	}
}
