package com.kh.campingez.admin.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.admin.model.dto.Stats;
import com.kh.campingez.admin.model.service.AdminService;
import com.kh.campingez.alarm.model.service.AlarmService;
import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.campzone.model.dto.Camp;
import com.kh.campingez.campzone.model.dto.CampPhoto;
import com.kh.campingez.campzone.model.dto.CampZone;
import com.kh.campingez.common.CampingEzUtils;
import com.kh.campingez.common.category.mode.dto.Category;
import com.kh.campingez.community.model.dto.Community;
import com.kh.campingez.coupon.model.dto.Coupon;
import com.kh.campingez.inquire.model.dto.Answer;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.report.dto.Report;
import com.kh.campingez.reservation.model.dto.Reservation;
import com.kh.campingez.trade.model.dto.Trade;
import com.kh.campingez.user.model.dto.User;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	AdminService adminService;
	
	@Autowired
	ServletContext application;
	
	@Autowired
	AlarmService alarmService;
	
	@GetMapping("/admin.do")
	public void admin() {}
	
	@GetMapping("/userList.do")
	public void userList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		List<User> userList = adminService.findAllUserList(param);
		model.addAttribute("userList", userList);
		
		int totalContent = adminService.getTotalContent();
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar2(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);
	}
	
	@GetMapping("/blackList.do")
	public void blackList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		List<User> blackList = adminService.findAllBlackList(param);
		List<User> userList = adminService.findAllNotBlackList(param);
		model.addAttribute("blackList", blackList);
		model.addAttribute("userList", userList);
		
		int BlacktotalContent = adminService.getBlackListTotalContent();
		int NotBlacktotalContent = adminService.getNotBlackListTotalContent();
		
		String url = request.getRequestURI();
		String blackPagebar = CampingEzUtils.getPagebar2(cPage, limit, BlacktotalContent, url);
		String notBlackPagebar = CampingEzUtils.getPagebar2(cPage, limit, NotBlacktotalContent, url);
		
		model.addAttribute("blackPagebar", blackPagebar);
		model.addAttribute("notBlackPagebar", notBlackPagebar);
	}

	@PostMapping("/warning.do")
	public ResponseEntity<?> warning(@RequestParam String userId, @RequestParam String reason) {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("reason", reason);
		
		int result = adminService.updateWarningToUser(param);
		result = alarmService.warningToUserAlarm(param);
		
		return ResponseEntity.ok().build();
	}
	
	@PostMapping("/cancelWarning.do")
	public ResponseEntity<?> cancelWarning(@RequestParam String userId, @RequestParam boolean isBlack) {
		int result = adminService.updateCancelWarningToUser(userId);
		result = alarmService.cancelWarningToUserAlarm(userId, isBlack);
		
		return ResponseEntity.ok().build();
	}
	
	@GetMapping("/selectUser.do")
	public ResponseEntity<?> selectUser(@RequestParam(defaultValue = "1") int cPage, @RequestParam String selectType, @RequestParam(required = false) String selectKeyword, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 10;
		param.put("selectType", selectType);
		param.put("selectKeyword", selectKeyword);
		param.put("cPage", cPage);
		param.put("limit", limit);

		List<User> userList = adminService.selectUserByKeyword(param);
		log.debug("userList = {}", userList);		
		
		int totalContent = adminService.getTotalContentByKeyword(param);
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, url);
		
		Map<String, Object> map = new HashMap<>();
		map.put("userList", userList);
		map.put("pagebar", pagebar);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(map);
	}
	
	@GetMapping("/selectUserNotBlackList.do")
	public ResponseEntity<?> selectUserNotBlackList(@RequestParam(defaultValue = "1") int cPage, @RequestParam String selectType, @RequestParam(required = false) String selectKeyword, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 10;
		param.put("selectType", selectType);
		param.put("selectKeyword", selectKeyword);
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		List<User> userList = adminService.selectNotBlackListByKeyword(param);
		log.debug("userList = {}", userList);		
		
		int totalContent = adminService.getTotalContentNotBlackListByKeyword(param);
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, url);
		
		Map<String, Object> map = new HashMap<>();
		map.put("userList", userList);
		map.put("pagebar", pagebar);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(map);
	}
	
	
	@GetMapping("/updateUserList")
	public ResponseEntity<?> updateUserList(@RequestParam String userId) {
		User user = adminService.findUserByUserId(userId);
		log.debug("user@updateUserList = {}", user);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(user);
	}
	
	@GetMapping("/inquireList.do")
	public void findAllInquireList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 10;
		param.put("limit", limit);
		param.put("cPage", cPage);
		
		List<Inquire> inquireList = adminService.findAllInquireList(param);
		model.addAttribute("inquireList", inquireList);
		
		int totalContent = adminService.getInquireListTotalContent();
		String uri = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar2(cPage, limit, totalContent, uri);
		model.addAttribute("pagebar", pagebar);
		
		List<Category> categoryList = adminService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
	}
	
	@PostMapping("/inquireAnswer.do")
	public String enrollAnswer(Answer answer, RedirectAttributes redirectAttr) {
		String location = "/inquire/inquireDetail.do?no=" + answer.getInqNo();
		int result = adminService.enrollAnswer(answer);
		redirectAttr.addFlashAttribute("msg", "????????? ?????????????????????.");
		
		Map<String, Object> param = new HashMap<>();
		param.put("answer", answer);
		param.put("location", location);
		result = alarmService.inquireAnswerAlarm(param);
		
		return "redirect:" + location;
	}
	
	@PostMapping("/deleteAnswer.do")
	public String deleteAnswer(Answer answer, RedirectAttributes redirectAttr) {
		int result = adminService.deleteAnswer(answer);
		
		return "redirect:/inquire/inquireDetail.do?no=" + answer.getInqNo();
	}
	
	@PostMapping("/updateAnswer.do")
	public String updateAnswer(Answer answer, RedirectAttributes redirectAttr, HttpServletRequest request) {
		int result = adminService.updateAnswer(answer);
		redirectAttr.addFlashAttribute("msg", "????????? ?????????????????????.");
		
		return "redirect:" + request.getHeader("Referer");
	}
	
	@GetMapping("/inquireListByCategoryId.do")
	public ResponseEntity<?> findInquireListByCategoryId(@RequestParam(defaultValue = "1") int cPage, @RequestParam String categoryId, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 10;
		param.put("limit", limit);
		param.put("cPage", cPage);
		param.put("categoryId", categoryId);
		
		List<Inquire> inquireList = adminService.findInquireListByCategoryId(param);
			
		int totalContent = adminService.getInquireListTotalContentByCategoryId(categoryId);
		String uri = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, uri);
		
		Map<String, Object> list = new HashMap<>();
		list.put("inquireList", inquireList);
		list.put("pagebar", pagebar);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(list);
	}
	
	@GetMapping("/reservationList.do")
	public void reservationList(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "res_date") String searchType, HttpServletRequest request, Model model) {
		Map<String, Object> param = new HashMap<>();

		// ?????? ?????? ?????? ?????? (3?????????~??????)
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date beforeThreeMon = addMonth(date, -3);
		String startDate = dateFormat.format(beforeThreeMon);
		String endDate = dateFormat.format(date);
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		param.put("searchType", searchType);
		model.addAttribute("date", param);
		
		// ????????? ??????
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		List<Reservation> reservationList = adminService.findReservationList(param);
		model.addAttribute("reservationList", reservationList);
		
		int totalContent = adminService.getReservationListTotalContent(param);
		String uri = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar2(cPage, limit, totalContent, uri);
		model.addAttribute("pagebar", pagebar);
	}
	
	@GetMapping("/reservationListBySelectType.do")
	public String reservationListBySelectType(@RequestParam(defaultValue = "1") int cPage, @RequestParam String searchType, @RequestParam String startDate, @RequestParam String endDate, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		param.put("searchType", searchType);
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		
		List<Reservation> reservationList = adminService.findReservationList(param);
		model.addAttribute("reservationList", reservationList);
		
		int totalContent = adminService.getReservationListTotalContent(param);
		String uri = request.getRequestURI() + "?searchType=" + searchType + "&startDate=" + startDate + "&endDate=" + endDate;
		log.debug("uri = {}", uri);
		String pagebar = CampingEzUtils.getPagebar2(cPage, limit, totalContent, uri);
		model.addAttribute("pagebar", pagebar);
		
		return "admin/reservationList";
	}
	
	@GetMapping("/campZoneList.do")
	public void campZoneList(Model model) {
		List<CampZone> campZoneList = adminService.findAllCampZoneList();
		log.debug("campZoneList = {}", campZoneList);
		model.addAttribute("campZoneList", campZoneList);
	}
	
	@GetMapping("/updateCampZone.do")
	public void updateCampZone(@RequestParam String zoneCode, Model model) {
		CampZone campZone = adminService.findCampZoneByZoneCode(zoneCode);
		log.debug("campZone = {}", campZone);
		model.addAttribute("campZone", campZone);
	}
	
	@PostMapping("/updateCampZone.do")
	public String updateCampZone(CampZone campZone, @RequestParam(name = "delFile", required = false) int[] zonePhotoNo, @RequestParam(name = "upFile") List<MultipartFile> upFileList, RedirectAttributes redirectAttr) throws IllegalStateException, IOException {
		String saveDirectory = application.getRealPath("/resources/upload/campPhoto");
		int result = 0;
		
		if(zonePhotoNo != null) {
			for(int photoNo : zonePhotoNo) {
				CampPhoto campPhoto = adminService.findCampPhotoByPhotoNo(photoNo);	
				File delFile = new File(saveDirectory, campPhoto.getRenamedFilename());
				boolean deleted = delFile.delete();
				if(deleted) {
					result = adminService.deleteCampPhotoByPhotoNo(photoNo);
				}
			}
		}
		
		for(MultipartFile upFile : upFileList) {
			if(upFile != null && !upFile.isEmpty()) {
				String renamedFilename = CampingEzUtils.getRenamedFilename(upFile.getOriginalFilename());
				File destFile = new File(saveDirectory, renamedFilename);
				upFile.transferTo(destFile);
				
				CampPhoto campPhoto = new CampPhoto(upFile.getOriginalFilename(), renamedFilename);
				campPhoto.setZoneCode(campZone.getZoneCode());
				campZone.campPhotoAdd(campPhoto);
			}
		}
		
		result = adminService.updateCampZone(campZone);
		redirectAttr.addFlashAttribute("msg", "?????? ????????? ??????????????? ?????????????????????.");
		return "redirect:/admin/campZoneList.do";
	}
	
	@GetMapping("/insertCampZone.do")
	public void insertCampZone(Model model) {
		List<CampZone> campZoneList = adminService.findAllCampZoneList();
		model.addAttribute("campZoneList", campZoneList);
	}
	
	@PostMapping("/insertCampZone.do")
	public String insertCampZone(CampZone campZone, @RequestParam(name = "upFile") List<MultipartFile> upFiles, RedirectAttributes redirectAttr) throws IllegalStateException, IOException {
		for(MultipartFile upFile : upFiles) {
			if(!upFile.isEmpty()) {				
				String saveDirectory = application.getRealPath("/resources/upload/campPhoto");
				String renamedFilename = CampingEzUtils.getRenamedFilename(upFile.getOriginalFilename());
				File destFile = new File(saveDirectory, renamedFilename);
				upFile.transferTo(destFile);
				
				CampPhoto campPhoto = new CampPhoto(upFile.getOriginalFilename(), renamedFilename);
				campZone.campPhotoAdd(campPhoto);
			}
		}
		
		int result = adminService.insertCampZone(campZone);
		redirectAttr.addFlashAttribute("msg", "????????? ??????????????? ?????????????????????.");
		
		return "redirect:/admin/campZoneList.do";
	}
	
	@PostMapping("/deleteCampZone.do")
	public String deleteCampZone(CampZone campZone) {
		List<CampPhoto> campPhotos = adminService.selectCampPhotoByZoneCode(campZone);
		if(!campPhotos.isEmpty()) {
			for(CampPhoto photo : campPhotos) {
				String saveDirectory = application.getRealPath("/resources/upload/campPhoto");
				File delFile = new File(saveDirectory, photo.getRenamedFilename());
				boolean deleted = delFile.delete();
				log.debug("deleted = {}", deleted);
			}
		}
		int result = adminService.deleteCampZone(campZone.getZoneCode());
		
		return "redirect:/admin/campZoneList.do";
	}
	
	@GetMapping("/campList.do")
	public void campList(Model model) {
		List<CampZone> campList = adminService.findAllCampList();
		log.debug("campList = {}", campList);
		List<CampZone> campZoneList = adminService.findAllCampZoneList();
		model.addAttribute("campList", campList);
		model.addAttribute("campZoneList", campZoneList);
	}

	@GetMapping("/statsVisited.do")
	public void statsVisited() {}
	
	@GetMapping("/statsVisitedChartByDate.do")
	public ResponseEntity<?> statsVisitedChartByDate(@RequestParam int year, @RequestParam int month) {
		Map<String, Object> param = new HashMap<>();
		param.put("year", year);
		param.put("month", month);
		log.debug("year = {}, month = {}", year, month);
		
		List<Stats> visitedList = adminService.statsVisitedChartByDate(param);
		log.debug("visitedList = {}", visitedList);
		
		int totalCount = adminService.statsVisitedTotalCount();
		int totalCountByDate = adminService.statsVisitedTotalCountByDate(param);
		param.put("visitedList", visitedList);
		param.put("totalCount", totalCount);
		param.put("totalCountByDate", totalCountByDate);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(param);
	}
	
	@GetMapping("/loginMemberListByDate.do")
	public ResponseEntity<?> loginMemberListByDate(@RequestParam String searchDate) {
		List<Stats> visitedList = adminService.getLoginMemberListByDate(searchDate);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(visitedList);
	}
	
	@GetMapping("/monthlySales.do")
	public void monthlySales() {}
	
	@GetMapping("/monthlySalesList.do")
	public ResponseEntity<?> monthlySalesList(@RequestParam int year) {
		// ?????? - ?????? ?????? ??????
		List<Stats> saleList = adminService.getMonthlySalesListByYear(year);
		// ?????? ?????? ??????
		int totalPrice = adminService.getTotalSalesPrice();
		
		Map<String, Object> param = new HashMap<>();
		param.put("year", year);
		param.put("saleList", saleList);
		param.put("totalPrice", totalPrice);
		
		// ?????? ????????? ?????? ??????
		int yearTotalPrice = adminService.getYearTotalSalesPrice(param);
		param.put("yearTotalPrice", yearTotalPrice);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(param);
	}
	
	@GetMapping("/saleListByMonth.do")
	public ResponseEntity<?> saleListByMonth(@RequestParam int year, @RequestParam(name = "searchMon") String month) {
		Map<String, Object> param = new HashMap<>();
		param.put("year", year);
		param.put("month", month);
		
		List<Stats> saleList = adminService.getSaleListByMonth(param);
		param.put("saleList", saleList);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(param);
	}
	
	@GetMapping("/duplicateCampId.do")
	public ResponseEntity<?> duplicateCampId(@RequestParam String campId) {
		Camp camp = adminService.selectCampByCampId(campId);
		boolean available = camp == null;
		
		Map<String, Object> param = new HashMap<>();
		param.put("camp", camp);
		param.put("available", available);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(param);
	}
	
	@PostMapping("/insertCamp.do")
	public String insertCamp(@RequestParam(name = "selectType") String zoneCode, @RequestParam String campId, RedirectAttributes redirectAttr) {
		Map<String, Object> param = new HashMap<>();
		param.put("zoneCode", zoneCode);
		param.put("campId", campId);
		
		int result = adminService.insertCamp(param);
		redirectAttr.addFlashAttribute("msg", "??????????????? ??????????????? ?????? ???????????????.");
		return "redirect:/admin/campList.do";
	}
	
	@PostMapping("/deleteCamp.do")
	public String deleteCamp(@RequestParam String campId) {
		log.debug("campId = {}", campId);
		int result = adminService.deleteCampByCampId(campId);
		return "redirect:/admin/campList.do";
	}
	
	@GetMapping("/findCampByZoneCode.do")
	public ResponseEntity<?> findCampByZoneCode(@RequestParam String zoneCode) {
		List<CampZone> campList = adminService.findCampByZoneCode(zoneCode);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(campList);
	}
	
	@GetMapping("/assignmentList.do")
	public void assignmentList(@RequestParam(defaultValue = "1") int cPage, HttpServletRequest request, Model model) {
		Map<String, Object> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		List<Assignment> assignmentList = adminService.findAllAssignmentList(param);
		int totalContent = adminService.getAssignmentTotalContent();
		String uri = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar2(cPage, limit, totalContent, uri);
		
		model.addAttribute("assignmentList", assignmentList);
		model.addAttribute("totalContent", totalContent);
		model.addAttribute("pagebar", pagebar);
		
		List<Assignment> expireAssignmentList = adminService.findAllExpireAssignmentList(param);
		int expireTotalContent = adminService.getExpireAssignmentTotalContent();
		String expirePagebar = CampingEzUtils.getPagebar2(cPage, limit, expireTotalContent, uri);
		
		model.addAttribute("expireAssignmentList", expireAssignmentList);
		model.addAttribute("expirePagebar", expirePagebar);
		model.addAttribute("expireTotalContent", expireTotalContent);
	}
	
	@GetMapping("/assignmentListBySelectType.do")
	public ResponseEntity<?> assignmentListBySelectType(@RequestParam(defaultValue = "1") int cPage, HttpServletRequest request, @RequestParam String selectType) {
		Map<String, Object> param = new HashMap<>();
		int limit = 5;
		param.put("cPage", cPage);
		param.put("limit", limit);
		param.put("selectType", selectType);
		
		List<Assignment> assignmentList = adminService.findAssignmentListBySelectType(param);
		log.debug("assignmentList = {}", assignmentList);
		int totalContent = adminService.getAssignmentBySelectTypeTotalContent(param);
		String uri = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, uri);
		
		Map<String, Object> data = new HashMap<>();
		data.put("assignmentList", assignmentList);
		data.put("pagebar", pagebar);
	
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(data);
	}
	
	@GetMapping("/tradeReportList.do")
	public void tradeReportList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		List<Trade> tradeReportList = adminService.findAllTradeReportList(param);
		log.debug("tradeReportList = {}", tradeReportList);
		model.addAttribute("tradeReportList", tradeReportList);
		
		List<Report> userReportTotal = adminService.findAllUserReportTotal(param);
		log.debug("userReportTotal = {}", userReportTotal);
		model.addAttribute("userReportTotal", userReportTotal);
		
		int totalContent = adminService.getTradeReportTotalContent();
		String uri = request.getRequestURI();
		String tradePagebar = CampingEzUtils.getPagebar2(cPage, limit, totalContent, uri);
		model.addAttribute("tradePagebar", tradePagebar);
		
		int userReportTotalContent = adminService.getUserReportTotalContent();
		String totalContentPagebar = CampingEzUtils.getPagebar2(cPage, limit, userReportTotalContent, uri);
		model.addAttribute("totalContentPagebar", totalContentPagebar);
	}
	
	@GetMapping("/commReportList.do")
	public void commReportList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		List<Community> commReportList = adminService.findAllCommReportList(param);
		log.debug("commReportList = {}", commReportList);
		model.addAttribute("commReportList", commReportList);
		
		List<Report> userReportTotal = adminService.findAllCommUserReportTotal(param);
		log.debug("userReportTotal = {}", userReportTotal);
		model.addAttribute("userReportTotal", userReportTotal);
		
		int totalContent = adminService.getCommReportTotalContent();
		String uri = request.getRequestURI();
		String commPagebar = CampingEzUtils.getPagebar2(cPage, limit, totalContent, uri);
		model.addAttribute("commPagebar", commPagebar);
		
		int userReportTotalContent = adminService.getCommUserReportTotalContent();
		String totalContentPagebar = CampingEzUtils.getPagebar2(cPage, limit, userReportTotalContent, uri);
		model.addAttribute("totalContentPagebar", totalContentPagebar);
	}
	
	@PostMapping("/updateReportAction.do")
	public String updateReportAction(@RequestParam String commNo, HttpServletRequest request) {
		int result = adminService.updateReportAction(commNo);
		
		return "redirect:" + request.getHeader("Referer");
	}
	
	@PostMapping("/updateReportActionAndIsDelete.do")
	public String updateReportActionAndIsDelete(@RequestParam String commNo, @RequestParam String type, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		String location = type.equals("T") ? "/trade/tradeView.do?no=" + commNo : "/community/communityView.do?no=" + commNo;
		param.put("commNo", commNo);
		param.put("type", type);
		param.put("location", location);
		
		int result = adminService.updateReportActionAndIsDelete(param);
		if(result > 0) {
			result = alarmService.commReportAlarm(param);
		}
		
		return "redirect:" + request.getHeader("Referer");
	}
	
	@GetMapping("/statsCouponDown.do")
	public void statsCouponDown(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		List<Coupon> ingCouponList = adminService.findAllIngCouponList(param);
		model.addAttribute("ingCouponList", ingCouponList);
		int ingCouponTotalContent = adminService.getIngCouponTotalContent();
		String uri = request.getRequestURI();
		String ingPagebar = CampingEzUtils.getPagebar2(cPage, limit, ingCouponTotalContent, uri);
		model.addAttribute("ingPagebar", ingPagebar);
		
		List<Coupon> expireCouponList = adminService.findAllExpireCouponList(param);
		model.addAttribute("expireCouponList", expireCouponList);
		int expireCouponTotalContent = adminService.getExpireCouponTotalContent();
		String expirePagebar = CampingEzUtils.getPagebar2(cPage, limit, expireCouponTotalContent, uri);
		model.addAttribute("expirePagebar", expirePagebar);
	}
	
	@PostMapping("/updateUserRole.do")
	public ResponseEntity<?> updateUserRole(@RequestParam String userId, @RequestParam String changeAuth) {
		log.debug("userId = {}, changeAuth = {}", userId, changeAuth);
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("changeAuth", changeAuth);
		
		int result = adminService.updateUserRole(param);
		
		return ResponseEntity.ok().build();
	}
	
	private Date addMonth(Date date, int months) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH, months);
		return cal.getTime();
	}
}