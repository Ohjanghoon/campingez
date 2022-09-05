package com.kh.campingez.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.kh.campingez.common.CampingEzUtils;
import com.kh.campingez.review.model.dto.Review;
import com.kh.campingez.review.model.dto.ReviewPhoto;
import com.kh.campingez.review.model.service.ReviewService;


import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/review")
@Slf4j
public class ReviewController {
	@Autowired
	private ReviewService reviewService;
	@Autowired
	ServletContext application;
	
	@Autowired
	ResourceLoader resourceLoader;
	
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
	@GetMapping("/reviewForm.do")
	public ModelAndView reviewForm(Authentication authentication, ModelAndView mav, Model model, @RequestParam String resNo) {
		model.addAttribute("resNo",resNo);
		System.out.println(resNo);
		mav.setViewName("review/reviewForm");
		
		return mav;
	}
	@PostMapping("/insertReview.do")
	public String boardEnroll(
			Review review, 
			@RequestParam(name = "upFile") List<MultipartFile> upFileList, 
			RedirectAttributes redirectAttr) 
					throws IllegalStateException, IOException {
		
		
		for(MultipartFile upFile : upFileList) {			

			if(!upFile.isEmpty()) {				
				// a. 서버컴퓨터에 저장
				String saveDirectory = application.getRealPath("/resources/upload/board");
				String renamedFilename = CampingEzUtils.getRenamedFilename(upFile.getOriginalFilename()); // 20220816_193012345_123.txt
				File destFile = new File(saveDirectory, renamedFilename);
				upFile.transferTo(destFile); // 해당경로에 파일을 저장
				
				// b. DB저장을 위해 Attachment객체 생성
				ReviewPhoto photo = new ReviewPhoto(upFile.getOriginalFilename(), renamedFilename);
				review.add(photo);
			}
		}
		
		log.debug("board = {}", review);
		
		// db저장
		int result = reviewService.insertReview(review);
		
		redirectAttr.addFlashAttribute("msg", "리뷰를 성공적으로 작성했습니다.");
		
		return "redirect:/userInfo/myReservation.do";
	}
}
