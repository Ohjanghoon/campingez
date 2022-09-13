package com.kh.campingez.trade.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.common.CampingEzUtils;
import com.kh.campingez.trade.model.dto.Trade;
import com.kh.campingez.trade.model.dto.TradeLike;
import com.kh.campingez.trade.model.dto.TradePhoto;
import com.kh.campingez.trade.model.service.TradeService;
import com.kh.campingez.user.model.dto.User;

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
		
//		List<TradePhoto> photoList = new ArrayList<>();
//		// 1. content영역
		Map<String, Integer> param = new HashMap<>();
		int limit = 12;
		param.put("cPage", cPage);
		param.put("limit", limit);
	
		list = tradeService.selectTradeList(param);
		model.addAttribute("list", list);
		log.debug("list = {} ", list);
		
		// 2. pagebar영역
		int totalContent = tradeService.getTotalContent();
		log.debug("totalContent = {}", totalContent);
		String url = request.getRequestURI(); // /spring/board/boardList.do
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
		
	}

	
	@GetMapping("/tradeView.do")
	public ModelAndView tradeView(
			@RequestParam String no, Model model,
			HttpServletResponse response, HttpServletRequest request,
			RedirectAttributes redirectAttr
			) throws Exception {
		
		// 로그인된 아이디 불러오기
		SecurityContext securityContext = SecurityContextHolder.getContext();
 		Authentication authentication = securityContext.getAuthentication();
 		Object principal = authentication.getPrincipal();
 		log.debug("prin = {}", principal);
 		
 		// 게시글 상세보기 쿼리
 		Trade trade = tradeService.selectTradeByNo(no);
 		model.addAttribute("trade", trade);
 		
 		TradeLike tl = new TradeLike();

 		// 로그인 한 아이디 확인(좋아요 구분용)
 		if(principal != "anonymousUser") {
 		User user = (User) principal;
 		String userId = user.getUserId();	
 		
 		model.addAttribute("user", user);
 		
 		tl.setLikeTradeNo(no);
 		tl.setLikeUserId(userId);
 		
 		int tradeLike = tradeService.getTradeLike(tl);
 		
 		model.addAttribute("heart", tradeLike);
 		} else {
 			int tradeLike = 0;
 			model.addAttribute("heart", tradeLike);
 		}
 		
		// 조회수 기능
		ModelAndView view = new ModelAndView();
        Cookie[] cookies = request.getCookies();
        
        // 비교하기 위해 새로운 쿠키
        Cookie viewCookie = null;
 
        // 쿠키가 있을 경우 
        if (cookies != null && cookies.length > 0) 
        {
            for (int i = 0; i < cookies.length; i++)
            {
                // Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌 
                if (cookies[i].getName().equals("cookie"+ no))
                { 
                	 log.debug("처음 쿠키가 생성한 뒤 들어옴.");
                    viewCookie = cookies[i];
                }
            }
        }
        if (trade != null) {
        	 log.debug("System - 해당 상세 리뷰페이지로 넘어감");
        	 
 
            // 만일 viewCookie가 null일 경우 쿠키를 생성해서 조회수 증가 로직을 처리함.
            if (viewCookie == null) {    
            	 log.debug("cookie 없음");
                // 쿠키 생성(이름, 값)
                Cookie newCookie = new Cookie("cookie"+ no, "|" + no + "|");  
                newCookie.setMaxAge(60 * 60 * 24);
                // 쿠키 추가
                response.addCookie(newCookie);
                // 쿠키를 추가 시키고 조회수 증가시킴
                int result = tradeService.updateReadCount(no);
                log.debug("리드카운트의 값은 : " + trade.getReadCount());
                
                if(result>=0) {
                	 log.debug("조회수 증가");
                }else {
                	 log.debug("조회수 증가 에러");
                }
            }
            // viewCookie가 null이 아닐경우 쿠키가 있으므로 조회수 증가 로직을 처리하지 않음.
            else {
            	 log.debug("cookie 있음");
                
                // 쿠키 값 받아옴.
                String value = viewCookie.getValue();
                log.debug("리드카운트의 값은 : " + trade.getReadCount());
                log.debug("cookie 값 : " + value);     
            }
            
            log.debug("result = {}", trade);
            view.setViewName("trade/tradeView");
            return view;
        } 
        else {
            // 에러 페이지 설정
            view.setViewName("error/tradeError");
            return view;
        }
        
        
        
        
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
	
	@ResponseBody
	@PostMapping(path = "/heart", produces = "application/json")
	public int heart(HttpServletRequest request) throws Exception{
		
		// 로그인 정보
		SecurityContext securityContext = SecurityContextHolder.getContext();
 		Authentication authentication = securityContext.getAuthentication();
 		Object principal = authentication.getPrincipal();
 		log.debug("prin = {}", principal);
 		
 		User user = (User) principal;
 		String userId = user.getUserId();
		
 		// 좋아요 쿼리
		int heart = Integer.parseInt(request.getParameter("heart"));
		String tradeNo = request.getParameter("tradeNo");
		
		TradeLike tl = new TradeLike();
		tl.setLikeTradeNo(tradeNo);
		tl.setLikeUserId(userId);
		
		if(heart >= 1) {
			tradeService.deleteTradeLike(tl);
			heart = 0;
		} else {
			tradeService.insertTradeLike(tl);
			heart = 1;
		}
		
		
		return heart;
	}
	
//	@GetMapping("/align")
//	public void tradeAlign(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
//		
//		List<Trade> list = new ArrayList<>();
////		// 1. content영역
//		Map<String, Integer> param = new HashMap<>();
//		int limit = 10;
//		param.put("cPage", cPage);
//		param.put("limit", limit);
//	
//		list = tradeService.selectTradeList(param);			
//		model.addAttribute("list", list);
//				
//		// 2. pagebar영역
//		int totalContent = tradeService.getTotalContent();
//		log.debug("totalContent = {}", totalContent);
//		String url = request.getRequestURI(); // /spring/board/boardList.do
//		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, url);
//		model.addAttribute("pagebar", pagebar);
//	}
	
	
	
}
