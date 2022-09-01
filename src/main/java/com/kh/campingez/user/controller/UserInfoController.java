package com.kh.campingez.user.controller;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
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
	
	
	@GetMapping("/userInfo.do")
	public ModelAndView memberDetail(Authentication authentication, ModelAndView mav) {
		
		Object principal = authentication.getPrincipal();
		Object credentials = authentication.getCredentials();
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		log.debug("principal = {}", principal);
		log.debug("credentials = {}", credentials);
		log.debug("authorities = {}", authorities);
		
		mav.setViewName("user/userInfo");
		return mav;
	}
	@PostMapping("/profileUpdate.do")
	public String profileUpdate(@ModelAttribute User user, RedirectAttributes redirectAttr, Model model) {
		log.debug("user = {}", user);
		// 1. db row 수정
		int result = userInfoService.profileUpdate(user);
		UserDetails updatedMember = userSecurityService.loadUserByUsername(user.getUserId());
		// 2. authentication 수정
		Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
					updatedMember,
					updatedMember.getPassword(),
					updatedMember.getAuthorities()
				);
		SecurityContextHolder.getContext().setAuthentication(newAuthentication);
		
		
		redirectAttr.addFlashAttribute("msg", "회원정보를 성공적으로 수정했습니다.");
		return "redirect:/userInfo/userInfo.do";
	}
}
