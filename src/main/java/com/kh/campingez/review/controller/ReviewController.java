package com.kh.campingez.review.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.campingez.admin.model.service.AdminService;
import com.kh.campingez.campzone.model.dto.CampZone;
import com.kh.campingez.common.CampingEzUtils;
import com.kh.campingez.review.model.dto.Review;
import com.kh.campingez.review.model.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/reviewList.do")
	public void reviewList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 5;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		List<Review> reviewList = reviewService.findAllReviewList(param);
		model.addAttribute("reviewList", reviewList);
		log.debug("reviewList = {}", reviewList);
		
		int totalContent = reviewService.getTotalContentByAllReviewList(param);
		String uri = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, uri);
		model.addAttribute("pagebar", pagebar);
		
		List<CampZone> campZoneList = adminService.findAllCampZoneList();
		model.addAttribute("campZoneList", campZoneList);
	}
	
	@GetMapping("/reviewListBySearchType.do")
	public String reviewList(@RequestParam(defaultValue = "1") int cPage, @RequestParam String searchType, @RequestParam(required = false) String campZoneType, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 5;
		param.put("cPage", cPage);
		param.put("limit", limit);
		param.put("campZoneType", campZoneType);
		param.put("searchType", searchType);
		
		List<Review> reviewList = new ArrayList<>();
		int totalContent = 0;
		
		if(searchType.equals("rev_photo_no")) {
			reviewList = reviewService.findReviewListContainsPhoto(param);
			totalContent = reviewService.getTotalContentAllReviewListContainsPhoto(param);
		} else {
			reviewList = reviewService.findReviewListBySearchType(param);
			totalContent = reviewService.getTotalContentByAllReviewList(param);
		}
		model.addAttribute("reviewList", reviewList);
		log.debug("reviewList = {}", reviewList);
		log.debug("totalContent = {}", totalContent);
		
		String uri = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, uri);
		model.addAttribute("pagebar", pagebar);
		log.debug("pagebar = {}", pagebar);
		
		List<CampZone> campZoneList = adminService.findAllCampZoneList();
		model.addAttribute("campZoneList", campZoneList);
		
		return "review/reviewList";
	}
	
	@GetMapping("/reviewDetail.do")
	public void reviewDetail(@RequestParam int revId, Model model) {
		Review review = reviewService.findOneReviewById(revId);
		model.addAttribute("review", review);
	}
}
