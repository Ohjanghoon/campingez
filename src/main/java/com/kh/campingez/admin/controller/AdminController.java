package com.kh.campingez.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.campingez.admin.model.service.AdminService;
import com.kh.campingez.common.CampingEzUtils;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.user.model.dto.User;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	AdminService adminService;
	
	@RequestMapping("/admin.do")
	public void admin() {}
	
	@RequestMapping("/userList.do")
	public void userList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		List<User> userList = adminService.findAllUserList(param);
		model.addAttribute("userList", userList);
		
		int totalContent = adminService.getTotalContent();
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, url);
		log.debug("pagebar = {}", pagebar);
		model.addAttribute("pagebar", pagebar);
	}

	@PostMapping("/warning")
	public ResponseEntity<?> warning(@RequestParam String userId) {
		log.debug("userId = {}", userId);
		int result = adminService.updateWarningToUser(userId);
		
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
	
	@GetMapping("/updateUserList")
	public ResponseEntity<?> updateUserList(@RequestParam String userId, Model model) {
		User user = adminService.findUserByUserId(userId);
		log.debug("user@updateUserList = {}", user);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(user);
	}
	
	@GetMapping("/inquireList.do")
	public void inquireList(Model model) {
		List<Inquire> inquireList = adminService.findAllInquireList();
		log.debug("inquireList = {}", inquireList);
		model.addAttribute("inquireList", inquireList);
	}
	
	@PostMapping("/inquireAnswer.do")
	public ResponseEntity<?> enrollAnswer(@PathVariable String content, @PathVariable int inqNo) {
		log.debug("answer = {}, {}", content, inqNo);
		
		return null;
	}
}
