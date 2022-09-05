package com.kh.campingez.user.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.user.model.dto.User;
import com.kh.campingez.user.model.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@GetMapping("/userEnroll.do")
	public String userEnroll() {
		return "user/userEnroll";
	}
	
	@PostMapping("/userEnroll.do")
	public String userEnroll(User user, RedirectAttributes redirectAttr) {
		try {
		log.debug("user = {}", user);
		
		//비밀번호 암호화
		String rawPassword = user.getPassword();
		log.debug("rawPassword = {}", rawPassword);
		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
		log.debug("encodedPassword = {}", encodedPassword);
		user.setPassword(encodedPassword);		
		
		int result = userService.insertUser(user);
		
		// 권한 부여
		int addAuthority = userService.insertAuthority(user.getUserId());
		
		redirectAttr.addFlashAttribute("msg", "회원가입 완료!");
		return "redirect:/";
		} catch(Exception e) {
			log.error("회원 등룍 오류 : " + e.getMessage(), e);
			throw e;
		}
	}
	
	@GetMapping("/userLogout.do")
	public String memberLogout(SessionStatus sessionStatus) {
		
		if(!sessionStatus.isComplete()) {
			sessionStatus.setComplete();
		}
		
		return "redirect:/";
	}
	
	@GetMapping("/userTest.do")
	public String userTest() {
		return "user/userTest";
	}
	
	@GetMapping("/userIdCheck.do")
	public ResponseEntity<?> userIdCheck(@RequestParam String userId) {
		//log.debug("userId = {}", userId);
		
		int result = userService.checkId(userId);
		//log.debug("result = {}", result);

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(result);

	};
	
}
