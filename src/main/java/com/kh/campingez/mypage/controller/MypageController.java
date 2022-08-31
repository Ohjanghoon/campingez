package com.kh.campingez.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.mypage.model.service.MypageService;
import com.kh.campingez.user.model.dto.User;




@RequestMapping("/mypage")
@Controller
public class MypageController {
	
	@Autowired
	private MypageService mypageService;
	
	@GetMapping("/mypage.do")
	public String myPageInfo(Model model) {
		String userId = "honggd";
		User result = mypageService.selectUserInfo(userId); 
		model.addAttribute("result", result);
		return "mypage/mypage";
	
	}
	@PostMapping("/profileUpdate.do")
	public String profileUpdate(User user, RedirectAttributes redirectAttr) {
		int result = mypageService.profileUpdate(user);
		System.out.println(user);
		redirectAttr.addFlashAttribute("msg", "수정되었습니다!.");
		return "redirect:/mypage/mypage.do";
	}

}
