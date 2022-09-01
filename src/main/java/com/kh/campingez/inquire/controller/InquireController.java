package com.kh.campingez.inquire.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public void inquireList(Model model) {
		
		List<Inquire> list = inquireService.selectInquireList();
		log.debug("list = {}", list);
		model.addAttribute("inquireList", list);
		
	}
	
	@GetMapping("/inquireDetail.do")
	public void inquireDetail(@RequestParam String no, Model model) {
		log.debug("no = {}", no);
		Inquire inquire = inquireService.selectInquire(no);
		log.debug("inquire = {}", inquire);
		
		model.addAttribute("inquire", inquire);
	}
	
	@GetMapping("/inquireForm.do")
	public void inquireForm() {
	}
	
	@PostMapping("/inquireEnroll.do")
	public String inquireEnroll(InquireEntity inquire, RedirectAttributes redirectAttr) {
		log.debug("inquire = {}", inquire);
		
		int result = inquireService.insertInquire(inquire);
		redirectAttr.addFlashAttribute("msg", "문의가 작성되었습니다.");
		return "redirect:/inquire/inquireList.do";
	}
}
