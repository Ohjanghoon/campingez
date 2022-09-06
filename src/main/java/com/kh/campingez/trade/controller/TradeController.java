package com.kh.campingez.trade.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
	
	@GetMapping("/tradeList")
	public void tradeList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		
		List<Trade> list = new ArrayList<>();
//		// 1. content영역
		Map<String, Integer> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);

		String col = request.getParameter("col");
		log.debug("col = {}", col);
		
		list = tradeService.selectTradeList(param);			
		model.addAttribute("list", list);
		
//		if(col == "recent") {
//		list = tradeService.selectTradeList(param);
//		}
//		else if (col == "lowPrice") {
//			list = tradeService.selectTradeListHighPrice(param);			
//		}
//		else if (col == "highPrice") {
//			list = tradeService.selectTradeListLowPrice(param);			
//		}
//		else {
//			log.debug("col = 문제 발생 해결 요함 *****" );
//		}
		
		
		
		
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
			Trade trade,
			@RequestParam(name = "upFile") List<MultipartFile> upFileList,
			RedirectAttributes redirectAttr) throws IllegalStateException, IOException {
		

		for(MultipartFile upFile : upFileList) {
			// 서버컴퓨터에 저장
			if(!upFile.isEmpty()) {
				String saveDirectory = application.getRealPath("/resources/upload/trade");
				String renamedFilename = CampingEzUtils.getRenamedFilename(upFile.getOriginalFilename());
				File destFile = new File(saveDirectory, renamedFilename);
				upFile.transferTo(destFile);
				
				// DB에 저장
				TradePhoto photo = new TradePhoto(upFile.getOriginalFilename(), renamedFilename);
				trade.add(photo);
			}
			
			
		}
		log.debug("trade = {}", trade);

		log.debug("upFileList = {}", upFileList);

		
		int result = tradeService.insertTrade(trade);
		
		redirectAttr.addFlashAttribute("msg", "게시글 등록 완료");
		
		return "redirect:/trade/tradeList.do";
	}
	
	@GetMapping("/tradeUpdate.do")
	public void tradeUpdate(@RequestParam String no, Model model) {
		Trade trade = tradeService.selectTradeByNo(no);
		model.addAttribute("trade", trade);
	}
	
	@PostMapping("/tradeUpdate.do")
	public String tradeUpdate(
				Trade trade,
				@RequestParam(name = "upFile") List<MultipartFile> upFileList,
				@RequestParam(name = "delFile", required = false) int[] delFiles,
				RedirectAttributes redirectAttr) throws IllegalStateException, IOException{
		String saveDirectory = application.getRealPath("/resources/upload/trade");
		int result = 0;
		// 첨부 파일 삭제
		if(delFiles != null) {
			for(int photoNo : delFiles) {
				// 서버에 저장된 파일 삭제
				TradePhoto photo = tradeService.selectOnePhoto(photoNo);
				File delFile = new File(saveDirectory, photo.getRenamedFilename());
				boolean deleted = delFile.delete();
				
				// DB의 photo row 삭제
				result = tradeService.deletePhoto(photoNo);
			}
		}
		
		// 업로드 파일 등록(서버 저장, insert할 포토객체 생성)
		for(MultipartFile upFile : upFileList) {
			if(!upFile.isEmpty()) {
				// 서버컴 저장
				if(!upFile.isEmpty()) {
					String renamedFilename = CampingEzUtils.getRenamedFilename(upFile.getOriginalFilename());
					File destFile = new File(saveDirectory, renamedFilename);
					upFile.transferTo(destFile);
					
					// DB에 저장
					TradePhoto photo = new TradePhoto(upFile.getOriginalFilename(), renamedFilename);
					photo.setTdNo(trade.getTradeNo()); // fk 설정
					trade.add(photo);
			}
		}
		
	}

	// 게시글 수정
	result = tradeService.updateTrade(trade);
	
	// 메시지
	redirectAttr.addFlashAttribute("msg", "수정 완료");
	
	return "redirect:/trade/tradeView.do?no=" + trade.getTradeNo();
	}
	
	@GetMapping("/tradeDelete")
	public String tradeDelete(RedirectAttributes redirectattr, @RequestParam String no) {
		int result = tradeService.deleteTrade(no);
		
		return "redirect:/trade/tradeList.do";
	}
	
	
}
