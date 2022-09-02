package com.kh.campingez.trade.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.common.CampingEzUtils;
import com.kh.campingez.trade.model.dto.Trade;
import com.kh.campingez.trade.model.dto.TradePhoto;
import com.kh.campingez.trade.model.service.TradeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/trade")
public class TradeController {
		
	@Autowired
	ServletContext application;
	
	@Autowired
	private TradeService tradeService;
	
	@GetMapping("/tradeList.do")
	public void tradeList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
//		// 1. content영역
		Map<String, Integer> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		List<Trade> list = tradeService.selectTradeList(param);
//		log.debug("list = {}", list);
		model.addAttribute("list", list);
		
		
		// 2. pagebar영역
		int totalContent = tradeService.getTotalContent();
		log.debug("totalContent = {}", totalContent);
		String url = request.getRequestURI(); // /spring/board/boardList.do
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
	}
	
	@GetMapping("/tradeView.do")
	public void tradeView(@RequestParam String no, Model model) {
		Trade trade = tradeService.selectTradeByNo(no);
		model.addAttribute("trade", trade);
	}
	
	@GetMapping("/tradeEnroll.do")
	public void tradeEnroll() {
		
	}
	
	@PostMapping("/tradeEnroll.do")
	public String tradeEnroll(
			@RequestParam(name = "upFile") List<MultipartFile> upFileList,
			RedirectAttributes redirectAttr) throws IllegalStateException, IOException {
		
		log.debug("upFileList = {}", upFileList);
		
//		for(MultipartFile upFile : upFileList) {
//			if(!upFile.isEmpty()) {
//				String saveDirectory = application.getRealPath("/resources/upload/trade");
//				String renamedFilename = CampingEzUtils.getRenamedFilename(upFile.getOriginalFilename());
//				File destFile = new File(saveDirectory, renamedFilename);
//				upFile.transferTo(destFile);
//				
//				TradePhoto photo = new TradePhoto(upFile.getOriginalFilename(), renamedFilename);
//				trade.add(photo);
//			}
//			
//			
//		}
//		log.debug("trade = {}", trade);
//		
//		int result = tradeService.insertTrade(trade);
//		
//		redirectAttr.addFlashAttribute("msg", "게시글 등록 완료");
		
		return "redirect:/trade/tradeList.do";
	}
	
	
}
