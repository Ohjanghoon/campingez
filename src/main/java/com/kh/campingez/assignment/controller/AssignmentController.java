package com.kh.campingez.assignment.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
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
	
	/**
	 * 양도 목록 더보기 전체 페이지 수 
	 */
	@GetMapping("/assignmentList.do")
	public void selectAssignmentList(@RequestParam(defaultValue = "1") int cPage, Model model) {
		String zoneSelect = null;
		int limit = 3;
		int totalContent = assignmentService.getTotalContent(zoneSelect);
		int totalPage = (int) Math.ceil((double) totalContent / limit);
		
		//log.debug("totalPage = {}, totalContent = {}", totalPage, totalContent);
		
		model.addAttribute("totalPage", totalPage);
	}

	/**
	 * 양도 목록에서 더보기 클릭시 현재 페이지 이후의 게시글 3개씩 불러오기 (비동기 요청)
	 */
	@GetMapping("/assignmentListMore.do")
	public ResponseEntity<?> selectAssignmentListMore(@RequestParam int cPage, @RequestParam String zoneSelect) {
		log.debug("cPage = {}", cPage);
		log.debug("zoneSelect = {}", zoneSelect);
		int photoCount = 4;
		int limit = 3;
		int start = (cPage - 1) * limit * photoCount + 1;
		int end = cPage * limit * photoCount;
		
		List<Assignment> list = assignmentService.selectAssignmentList(zoneSelect, start, end);
		log.debug("list = {}", list);
		int totalContent = assignmentService.getTotalContent(zoneSelect);
		log.debug("totalContent = {}", totalContent);
		int totalPage = (int) Math.ceil((double) totalContent / limit);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("totalPage", totalPage);
		
		return ResponseEntity.status(HttpStatus.OK)
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
				.body(map);
	}
	
	/**
	 * 양도하기 가능한 예약을 조회 → 양도하기 폼 요청 후 페이지으로 이동
	 */
	@PostMapping("/assignmentForm.do")
	public void assignmentEnroll(Model model, @RequestParam String userId) {
		//log.debug("userId = {}", userId);
		
		List<Reservation> list = assignmentService.selectReservationList(userId);
		//log.debug("reservationList = {}", list);
		
		model.addAttribute("reservationList", list);
	}
	
	/**
	 * 양도하기 가능한 예약을 클릭시 → 해당 예약정보 조회 (비동기 요청)
	 */
	@PostMapping("/resInfo.do")
	public ResponseEntity<?> selectResInfo(@RequestParam String resNo) {
		//log.debug("resNo = {}", resNo);
		
		Reservation resInfo = assignmentService.selectResInfo(resNo);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(resInfo);
	}
	
	/**
	 * 양도하기 등록 폼 제출 
	 */
	@PostMapping("/assignmentEnroll.do")
	public String insertAssignment(AssignmentEntity assignment, RedirectAttributes redirectAttr) {
//		log.debug("assignment = {}", assignment);
		
		int result = assignmentService.insertAssignment(assignment);
		redirectAttr.addFlashAttribute("msg", "양도 등록되었습니다.");
		return "redirect:/assignment/assignmentList.do";
	}
	
	/**
	 * 양도 상세보기 페이지 
	 */
	@GetMapping("/assignmentDetail.do")
	public void assignmentDetail(@RequestParam String assignNo, Model model) {
//		log.debug("assignNo = {}", assignNo);
		
		Assignment assign = assignmentService.assignmentDetail(assignNo);
//		log.debug("assign", assign);
		
		model.addAttribute("assign", assign);
	}
	
	/**
	 * 양도받기 신청 폼 요청 후 페이지으로 이동 
	 */
	@PostMapping("/assignmentApplyForm.do")
	public void assignmentApply(@RequestParam String assignNo, Model model) {
//		log.debug("assignNo = {}", assignNo);
		
		Assignment assign = assignmentService.assignmentDetail(assignNo);
//		log.debug("assign = {}", assign);
		
//		String location = "";
//		if(assign != null) {
//			assign = assignmentService.assignmentDetail(assignNo);
//			location = "redirect:/assignmentApplyForm.do";
//		} else {
//			location = "redirect:/assignment/assignmentList.do";
//			model.addAttribute("msg", "다시 시도 부탁드립니다.");
//		}
		model.addAttribute("assign", assign);
//		return location;
//		response.addCookie(applyCookie);
	}
	
	/**
	 * 양도받기 가능한 양도건인지 조회 후 요청 처리 (비동기 요청)
	 */
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
	
	/**
	 * 양도받기 신청 폼 제출 
	 */
	@PostMapping("/assignmentApply.do")
	public String assignmentApply(
			@RequestParam String assignNo,
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
		//log.debug("reservation = {}", reservation);
		
		String alreadyResNo = assignmentService.selectOneReservation(reservation);
		log.debug("alreadyResNo%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% = {}", alreadyResNo);
		
		Reservation result = new Reservation();
		// 이미 등록된 양도 예약이 없을 경우
		if(alreadyResNo == null) {
			result = assignmentService.insertAssignmentApply(reservation);
		}
		// 이미 등록된 양도 예약이 있을 경우
		else {
			reservation.setResNo(alreadyResNo);
			result = assignmentService.updateAssignmentApply(reservation);
		}
		log.debug("result = {}", result);
	
		redirectAttr.addFlashAttribute("payRes", result);
		redirectAttr.addFlashAttribute("assignNo", assignNo);
		return "redirect:/payment/payment.do";
	}
	
	/**
	 * 1분마다 실행되면서 결제시간이 10분 지난 양도테이블 - '양도중' 상태 및 예약테이블 - '양도결제대기' 처리 
	 */
	@Scheduled(cron="0 0/1 * * * *")
	public void assignmentLimitTime() {
		
		int result = assignmentService.assignmentLimitTime();
		System.out.println(LocalDateTime.now() + " ======> 10분 지난 데이터 삭제!");
	}
	
	@PostMapping("/assignmentDelete.do")
	public ResponseEntity<?> assignmentDelete(@RequestParam String assignNo) {
		//log.debug("assignNo = {}", assignNo);
		
		int result = assignmentService.deleteAssignment(assignNo);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(result);
	}
}
