package com.kh.campingez.review.controller;

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

import com.kh.campingez.common.CampingEzUtils;
import com.kh.campingez.review.model.dto.Review;
import com.kh.campingez.review.model.service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	private ReviewService reviewService;
	
	@GetMapping("/reviewList.do")
	public void reviewList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 5;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		List<Review> reviewList = reviewService.findAllReviewList(param);
		model.addAttribute("reviewList", reviewList);
		
		int totalContent = reviewService.getTotalContentByAllReviewList();
		String uri = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, uri);
		
		model.addAttribute("pagebar", pagebar);
	}
}
