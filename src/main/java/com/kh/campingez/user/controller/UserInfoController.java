package com.kh.campingez.user.controller;




import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.assignment.model.dto.AssignmentEntity;
import com.kh.campingez.common.CampingEzUtils;
import com.kh.campingez.coupon.model.dto.Coupon;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.reservation.model.dto.Reservation;
import com.kh.campingez.review.model.dto.ReviewEntity;
import com.kh.campingez.review.model.dto.ReviewPhoto;
import com.kh.campingez.trade.model.dto.TradeEntity;
import com.kh.campingez.user.model.dto.MyPage;
import com.kh.campingez.user.model.dto.User;
import com.kh.campingez.user.model.service.UserInfoService;
import com.kh.security.model.service.UserSecurityService;


import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/userInfo")
@Slf4j
public class UserInfoController {

	@Autowired
	private UserInfoService userInfoService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private UserSecurityService userSecurityService;
	
	//회원 마이페이지 jsp 호추루루룰
	@GetMapping("/myPage.do")
	public ModelAndView myPage(@RequestParam(defaultValue = "1") int cPage, Authentication authentication, ModelAndView mav, Model model) {
		User principal = (User)authentication.getPrincipal();
		Map<String, Object> param = new HashMap<>();
		int limit = 3;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		//로그인된 회원의 1:1 문의 답변 확인
		List<MyPage> inquireCnt = userInfoService.selectInquireCnt(principal);
		model.addAttribute("inquireCnt",inquireCnt);
		
		//로그인된 회원의 중고 거래 게시판 상황.
		List<MyPage> tradeCnt = userInfoService.selectTradeCnt(principal);
		model.addAttribute("tradeCnt",tradeCnt);
		
		//로그인된 회원의 입실 예정 객실조회
		List<Reservation> reservationList= userInfoService.selectReservation(principal);
		model.addAttribute("reservationList",reservationList);
		
		//로그인된 회원이 다운받은 쿠폰 조회해오기
		List<Coupon> couponList = userInfoService.selectCoupon(principal); 
		model.addAttribute("couponList",couponList);
		
		//로그인된 회원이 등록한 양도글 조회.
		
		List<AssignmentEntity> assignList = userInfoService.selectAssignList(param, principal); 
		model.addAttribute("assignList",assignList);
	
		mav.setViewName("user/myPage");
		return mav;
	}
	
	/**
	 * !!!!!!!!!!!!!!!!회원정보 수정!!!!!!!!!!!!!!!!!!!!!
	 */
	//내정보 수정 인증페이지 (비밀번호 재확인으로 만들것임!)
	@GetMapping("/popupAuthentication.do")
	public ModelAndView popupAuthentication(ModelAndView mav) {
		mav.setViewName("user/authentication");
		return mav;
	}
	//회원 조회 jsp 호출
	@GetMapping("/userInfo.do")
	public ModelAndView userInfo(ModelAndView mav) {
		mav.setViewName("user/userInfo");
		return mav;
	}
	//회원 정보 수정전 로그인 다시 인증하기 
	@GetMapping("/authentication.do")
	public ResponseEntity<Map<String, Object>> authentication(@ModelAttribute User user ,Authentication authentication) {
		User principal = (User)authentication.getPrincipal();
		System.out.println(user.getUserId()+"," +principal.getUserId()+"," +user.getPassword()+"," +principal.getPassword());
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		Map<String , Object> resultMap = new HashMap<>(); 
		if(user.getUserId().equals(principal.getUserId()) && encoder.matches(user.getPassword(), principal.getPassword())) {
			resultMap.put("msg", "success");
			
		}else {
			resultMap.put("msg", "fail");
			
		}
			return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(resultMap);
	}
	//회원 정보 수정
	@PostMapping("/profileUpdate.do")
	public String profileUpdate(@ModelAttribute User user, RedirectAttributes redirectAttr, Model model, Authentication authentication) {
		User principal = (User)authentication.getPrincipal();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		if(encoder.matches(user.getCPassword(), principal.getPassword())){
			String rawPassword = "";
			if(!user.getRPassword().isEmpty()) {
				rawPassword = user.getRPassword();
			}else {
				rawPassword = user.getCPassword();
			}
			log.debug("rawPassword = {}", rawPassword);
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			log.debug("encodedPassword = {}", encodedPassword);
			user.setPassword(encodedPassword);		
			
			// 1. db row 수정
			int result = userInfoService.profileUpdate(user);
			if(result > 0) {
				UserDetails updatedMember = userSecurityService.loadUserByUsername(user.getUserId());
				// 2. authentication 수정
				Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
						updatedMember,
						updatedMember.getPassword(),
						updatedMember.getAuthorities()
						);
				SecurityContextHolder.getContext().setAuthentication(newAuthentication);
				redirectAttr.addFlashAttribute("msg", "회원정보를 성공적으로 수정했습니다.");			
			}
		}else {
			redirectAttr.addFlashAttribute("msg", "Current Password 가 일치 하지 않습니다.");
		}
		log.debug("user = {}", user);
		

		return "redirect:/userInfo/userInfo.do";
	}
	//회원 탈퇴
	@PostMapping("/profileDelete.do")
	public String profileDelete(@ModelAttribute User user, RedirectAttributes redirectAttr, Model model) {
		log.debug("user = {}", user);
		// 회원 탈퇴
		int result = userInfoService.profileDelete(user);
		if(result > 0) {
			SecurityContextHolder.clearContext();
			redirectAttr.addFlashAttribute("msg", "정상적으로 탈퇴 되었습니다.");			
		}
		return "redirect:/";
	}
	
	/**
	 * !!!!!!!!!!!!!!!!자기 문의글 보기!!!!!!!!!!!!!!!!!!!!!
	 */
	@GetMapping("/inquireList.do")
	public ModelAndView inquireList(@RequestParam(defaultValue = "1") int cPage, Authentication authentication ,Model model, ModelAndView mav,HttpServletRequest request) {
		int limit = 3;
		Map<String, Object> param = new HashMap<>();
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		User principal = (User)authentication.getPrincipal();
		List<Inquire> list = userInfoService.selectInquireList(param, principal);
		log.debug("list = {}", list);
		
		//2. pagebar 처리
		int totalInquire = userInfoService.getTotalInquire(principal);
		log.debug("totalContent = {}", totalInquire);
	
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar2(cPage, limit, totalInquire, url);
		model.addAttribute("pagebar", pagebar);
		
		model.addAttribute("inquireList", list);
		model.addAttribute("prePageName", "mypage");
		model.addAttribute("cPage", cPage);
		model.addAttribute("limit", limit);
		model.addAttribute("totalContent", totalInquire);
		mav.setViewName("inquire/inquireList");
		return mav;
	}
	
	/**
	 * !!!!!!!!!!!!!!!!본인 예약글 확인!!!!!!!!!!!!!!!!!!!!! 
	 */
	@GetMapping("/myReservation.do")
	public ModelAndView reservationCheck(@RequestParam(defaultValue = "1") int cPage, Authentication authentication ,
											Model model, ModelAndView mav, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 6;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		User principal = (User)authentication.getPrincipal();
		List<Reservation> list = userInfoService.selectReservationList(param, principal);
		log.debug("list = {}", list);
		
		int totalReservation =  userInfoService.getTotalReservation(principal);
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalReservation, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("reservationList", list);
		mav.setViewName("user/myReservation");
		return mav;
	}
	
	/**
	 * !!!!!!!!!!!!!!!!예약글 ajax!!!!!!!!!!!!!!!!!!!!! 
	 */
	@PostMapping("/myReservation.do")
	public ModelAndView reservationAjax(@RequestParam(defaultValue = "1") int cPage, Authentication authentication ,
											Model model, ModelAndView mav, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 6;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		User principal = (User)authentication.getPrincipal();
		List<Reservation> list = userInfoService.selectReservationList(param, principal);
		log.debug("list = {}", list);
		
		int totalReservation =  userInfoService.getTotalReservation(principal);
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalReservation, url);
		log.debug("pagebar = {}", pagebar);
		

		model.addAttribute("pagebar", pagebar);
		model.addAttribute("reservationList", list);
		mav.setViewName("user/myReservationAjax");
		return mav;
	}
	
	
	/**
	 * !!!!!!!!!!!!!!!!양도 글 확인!!!!!!!!!!!!!!!!!!!!! 
	 */
	@GetMapping("/assignment.do")
	public ModelAndView assignList(@RequestParam(defaultValue = "1") int cPage,Authentication authentication,
									ModelAndView mav, Model model,HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 6;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		User principal = (User)authentication.getPrincipal();
		List<AssignmentEntity> list = userInfoService.selectAssignList(param, principal);
		log.debug("list = {}", list);
		System.out.println(list);
		int totalContent =  userInfoService.getTotalAssignment(principal);
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		System.out.println(cPage);
		model.addAttribute("pagebar", pagebar);
		
		model.addAttribute("assignList", list);
		mav.setViewName("user/myAssignment");
		return mav;
	}
	/**
	 * !!!!!!!!!!!!!!!!양도 글 ajax 용!!!!!!!!!!!!!!!!!!!!! 
	 */
	@PostMapping("/assignment.do")
	public ResponseEntity<Map<String, Object>> assignAjax(@RequestParam(defaultValue = "1") int cPage,Authentication authentication,
									ModelAndView mav, Model model,HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 6;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		User principal = (User)authentication.getPrincipal();
		List<AssignmentEntity> list = userInfoService.selectAssignList(param, principal);
		log.debug("list = {}", list);
		System.out.println(list);
		int totalContent =  userInfoService.getTotalAssignment(principal);
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		
		Map<String , Object> resultMap = new HashMap<>(); 
			resultMap.put("pagebar", pagebar);
			resultMap.put("assignList", list);
			return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(resultMap);
	}
	 
	/**
	 * !!!!!!!!!!!!!!!!중고거래 게시판 글!!!!!!!!!!!!!!!!!!!!! 
	 */
	@GetMapping("/myTradeList.do")
	public ModelAndView myTradeList(@RequestParam(defaultValue = "1") int cPage ,Authentication authentication, 
										ModelAndView mav, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 6;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		User principal = (User)authentication.getPrincipal();
		List<TradeEntity> result = userInfoService.selectTradeList(param, principal);
		log.debug("list = {}", result);
		
		int totalTrade =  userInfoService.getTotalTrade(principal);
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalTrade, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("result", result);
		mav.setViewName("user/myTradeList");
		return mav;
	}
	
	/**
	 * !!!!!!!!!!!!!!!!중고거래 ajax !!!!!!!!!!!!!!!!!!!!! 
	 */
	@PostMapping("/myTradeList.do")
	public ResponseEntity<Map<String, Object>> tradeAjax(@RequestParam(defaultValue = "1") int cPage ,Authentication authentication, 
										ModelAndView mav, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 6;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		User principal = (User)authentication.getPrincipal();
		List<TradeEntity> result = userInfoService.selectTradeList(param, principal);
		log.debug("list = {}", result);
		
		int totalTrade =  userInfoService.getTotalTrade(principal);
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalTrade, url);
		log.debug("pagebar = {}", pagebar);
		System.out.println(cPage + "아래것");
		System.out.println(result);
		Map<String , Object> resultMap = new HashMap<>(); 
		resultMap.put("pagebar", pagebar);
		resultMap.put("result", result);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(resultMap);
	}
	
	/**
	 * !!!!!!!!!!!!!!!!찜목록리스트!!!!!!!!!!!!!!!!!!!!! 
	 */
	@GetMapping("/myLikeList.do")
	public ModelAndView myLikeList(@RequestParam(defaultValue = "1") int cPage ,Authentication authentication, 
										ModelAndView mav, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 6;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		User principal = (User)authentication.getPrincipal();
		List<TradeEntity> result = userInfoService.selectLikeList(param, principal);
		log.debug("list = {}", result);
		
		int totalLikeCount =  userInfoService.getTotalLike(principal);
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalLikeCount, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);
		model.addAttribute("result", result);
		mav.setViewName("user/myLikeList");
		return mav;
	}

	/**
	 * !!!!!!!!!!!!!!!!찜목록리스트 ajax !!!!!!!!!!!!!!!!!!!!! 
	 */
	@PostMapping("/myLikeList.do")
	public ResponseEntity<Map<String, Object>> likeListAjax(@RequestParam(defaultValue = "1") int cPage ,Authentication authentication, 
										ModelAndView mav, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 6;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		User principal = (User)authentication.getPrincipal();
		List<TradeEntity> result = userInfoService.selectLikeList(param, principal);
		log.debug("list = {}", result);
		
		int totalLikeCount =  userInfoService.getTotalLike(principal);
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalLikeCount, url);
		log.debug("pagebar = {}", pagebar);
		Map<String , Object> resultMap = new HashMap<>(); 
		resultMap.put("pagebar", pagebar);
		resultMap.put("result", result);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(resultMap);
	}
	
	/**
	 * !!!!!!!!!!!!!!!!내 예약상세 보기 !!!!!!!!!!!!!!!!!!!!! 
	 */
	@GetMapping("/resDetail.do")
	public ModelAndView resDetail(Authentication authentication, ModelAndView mav, Model model, @RequestParam String resNo) {
		
		Reservation res = userInfoService.selectReservationDetail(resNo);
		model.addAttribute("res",res);
		model.addAttribute("resNo",resNo);
		mav.setViewName("user/reservationDetail");
		return mav;		
	}
}
