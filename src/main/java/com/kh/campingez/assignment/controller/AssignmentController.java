package com.kh.campingez.assignment.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
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
	public void selectAssignmentList(@RequestParam(defaultValue = "1") int cPage, Model model) {
		int limit = 3;
		int totalContent = assignmentService.getTotalContent();
		int totalPage = (int) Math.ceil((double) totalContent / limit);
		
		log.debug("totalPage = {}, totalContent = {}", totalPage, totalContent);
		
		model.addAttribute("totalPage", totalPage);
		
	}
	
	
	@GetMapping("/assignmentListMore.do")
	public ResponseEntity<?> selectAssignmentListMore(@RequestParam int cPage) {
		log.debug("cPage = {}", cPage);
		int photoCount = 4;
		int limit = 3;
		int start = (cPage - 1) * limit * photoCount + 1;
		int end = cPage * limit * photoCount;
		
		List<Assignment> list = assignmentService.selectAssignmentList(start, end);
		log.debug("list = {}", list);
		
		return ResponseEntity.status(HttpStatus.OK)
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
				.body(list);
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
	
	@PostMapping("/assignmentCheck.do")
	public ResponseEntity<?> assignmentCheck(@RequestParam String assignNo, @RequestParam String assignTransfer){
		log.debug("assignNo = {}", assignNo);
		log.debug("assignTransfer = {}", assignTransfer);
		
		String assignState = assignmentService.selectAssignState(assignNo);
		
		Boolean assignCheck = false;
		if("양도대기".equals(assignState)) {
			assignCheck = true;
			int result = assignmentService.updateAssignStateAndTransfer(assignNo, assignTransfer);
		}
		log.debug("assignCheck = {}", assignCheck);
		
//		return ResponseEntity.ok(null);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(assignCheck);
	}
	
	@PostMapping("/assignmentApply.do")
	public String assignmentApply(
			@RequestParam String checkin,
			@RequestParam String checkout,
			Reservation reservation,
			RedirectAttributes redirectAttr) {
		
		//입/퇴실일자 날짜형 변환
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		LocalDate resCheckin = LocalDate.parse(checkin, dtf);
		LocalDate resCheckout = LocalDate.parse(checkout, dtf);
		
		reservation.setResCheckin(resCheckin);
		reservation.setResCheckout(resCheckout);
		log.debug("reservation = {}", reservation);
		
		Reservation result = assignmentService.insertAssignmentApply(reservation);
		log.debug("result = {}", result);
	
		redirectAttr.addFlashAttribute("payRes", result);
		
		return "redirect:/payment/payment.do";
	}
}
