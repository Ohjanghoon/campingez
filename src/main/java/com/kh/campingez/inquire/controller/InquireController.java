package com.kh.campingez.inquire.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.common.CampingEzUtils;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.inquire.model.dto.InquireEntity;
import com.kh.campingez.inquire.model.service.InquireService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/inquire")
public class InquireController {

	@Autowired
	InquireService inquireService;
	
	@GetMapping("/inquireList.do")
	public void inquireList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		//1. content 영역
		Map<String, Integer> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		List<Inquire> list = inquireService.selectInquireList();
		//log.debug("list = {}", list);
		model.addAttribute("inquireList", list);
		
		//2. pagebar 처리
		int totalContent = inquireService.getTotalContent();
		log.debug("totalContent = {}", totalContent);
	
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
	}
	
	@GetMapping("/inquireDetail.do")
	public void inquireDetail(@RequestParam String no, Model model) {
		//log.debug("inqNo = {}", inqNo);
		String inqNo = no;
		Inquire inquire = inquireService.selectInquire(inqNo);
		//log.debug("inquire = {}", inquire);
		
		model.addAttribute("inquire", inquire);
	}
	
	@GetMapping("/inquireForm.do")
	public void inquireForm() {
	}
	
	@PostMapping("/inquireEnroll.do")
	public String inquireEnroll(InquireEntity inquire, RedirectAttributes redirectAttr) {
		//log.debug("inquire = {}", inquire);
		
		int result = inquireService.insertInquire(inquire);
		redirectAttr.addFlashAttribute("msg", "문의가 작성되었습니다.");
		return "redirect:/inquire/inquireList.do";
	}
	
	@GetMapping("/inquireUpdate.do")
	public void inquireUpdate(@RequestParam String no, Model model) {
		//log.debug("inqNo = {}", inqNo);
		String inqNo = no;
		Inquire inquire = inquireService.selectInquire(inqNo);
		
		model.addAttribute("inquire", inquire);
	}
	
	@PostMapping("/inquireUpdate.do")
	public String inquireUpdate(Inquire inquire, RedirectAttributes redirectAttr) {
		//log.debug("inquire = {}", inquire);
		
		int result = inquireService.updateInquire(inquire);
		
		redirectAttr.addFlashAttribute("msg", "수정 완료하였습니다.");
		
		return "redirect:/inquire/inquireDetail.do?no=" + inquire.getInqNo();
	}
	
	@PostMapping("/inquireDelete.do")
	public String inquireDelete(@RequestParam String inqNo, RedirectAttributes redirectAttr) {
		int result = inquireService.deleteInquire(inqNo);
		
		redirectAttr.addFlashAttribute("msg", "삭제 되었습니다.");
		return "redirect:/inquire/inquireList.do";
	}
}
