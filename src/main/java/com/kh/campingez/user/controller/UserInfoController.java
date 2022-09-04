package com.kh.campingez.user.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.reservation.model.dto.Reservation;
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
	private UserSecurityService userSecurityService;
	
	//회원 마이페이지 jsp 호추루루룰
	@GetMapping("/myPage.do")
	public ModelAndView myPage(Authentication authentication, ModelAndView mav, Model model) {
		User principal = (User)authentication.getPrincipal();
		List<MyPage> inquireCnt = userInfoService.selectInquireCnt(principal);
		List<Reservation> reservationList= userInfoService.selectReservation(principal);
		model.addAttribute("inquireCnt",inquireCnt);
		model.addAttribute("reservationList",reservationList);
		mav.setViewName("user/myPage");
		
		return mav;
	}
	
	/**
	 * !!!!!!!!!!!!!!!!회원정보 수정!!!!!!!!!!!!!!!!!!!!!
	 */
	//내정보 수정 인증페이지 (비밀번호 재확인으로 만들것임!)
	@GetMapping("/authentication.do")
	public ModelAndView authentication(ModelAndView mav) {
		mav.setViewName("user/authentication");
		return mav;
	}
	//회원 조회 jsp 호출
	@GetMapping("/userInfo.do")
	public ModelAndView userDetail(@ModelAttribute User user ,Authentication authentication, Model model, ModelAndView mav) {
		User principal = (User)authentication.getPrincipal();
		System.out.println(user.getUserId()+"," +principal.getUserId()+"," +user.getPassword()+"," +principal.getPassword());
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if(user.getUserId().equals(principal.getUserId()) && encoder.matches(user.getPassword(), principal.getPassword())) {
			model.addAttribute("msg", "success");
			
		}else {
			model.addAttribute("msg", "fail");
			
		}
			mav.setViewName("user/authentication");
			return mav;
	}
	//회원 정보 수정
	@PostMapping("/profileUpdate.do")
	public String profileUpdate(@ModelAttribute User user, RedirectAttributes redirectAttr, Model model) {
		log.debug("user = {}", user);
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
	public ModelAndView inquireList(Authentication authentication ,Model model, ModelAndView mav) {
		User principal = (User)authentication.getPrincipal();
		List<Inquire> list = userInfoService.selectInquireList(principal);
		log.debug("list = {}", list);
		model.addAttribute("inquireList", list);
		model.addAttribute("prePageName", "mypage");
		mav.setViewName("inquire/inquireList");
		return mav;
	}
	
	/**
	 * !!!!!!!!!!!!!!!!본인 예약글 확인!!!!!!!!!!!!!!!!!!!!! 
	 */
	@GetMapping("/myReservation.do")
	public ModelAndView reservationCheck(Authentication authentication ,Model model, ModelAndView mav) {
		User principal = (User)authentication.getPrincipal();
		List<Reservation> list = userInfoService.selectReservationList(principal);
		log.debug("list = {}", list);
		model.addAttribute("reservationList", list);
		mav.setViewName("user/myReservation");
		return mav;
	}
}
