package com.kh.campingez.trade.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
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
import com.kh.campingez.common.category.mode.dto.Category;
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
		

		
	}

	
	@GetMapping("/tradeView.do")
	public ModelAndView tradeView(
			@RequestParam String no, Model model,
			HttpServletResponse response, HttpServletRequest request,
			RedirectAttributes redirectAttr
			) throws Exception {
		
		// ???????????? ????????? ????????????
		SecurityContext securityContext = SecurityContextHolder.getContext();
 		Authentication authentication = securityContext.getAuthentication();
 		Object principal = authentication.getPrincipal();
 		log.debug("prin = {}", principal);
 		
 		// ????????? ???????????? ??????
 		Trade trade = tradeService.selectTradeByNo(no);
 		model.addAttribute("trade", trade);
 		String userId = principal != "anonymousUser" ? ((User)principal).getUserId() : null;
 		Map<String, Object> param = new HashMap<>();
 		param.put("no", no);
 		param.put("userId", userId);
 		String reportUserId = tradeService.getUserReportTrade(param);
 		log.debug("reportUserId = {}", reportUserId);
 		model.addAttribute("reportUserId", reportUserId);
 		
 		List<Category> categoryList = tradeService.getReportCategory();
 		model.addAttribute("categoryList", categoryList);
 		
 		TradeLike tl = new TradeLike();

 		// ????????? ??? ????????? ??????(????????? ?????????)
 		if(principal != "anonymousUser") {
 		User user = (User) principal;
 		userId = user.getUserId();	
 		
 		model.addAttribute("user", user);
 		
 		tl.setLikeTradeNo(no);
 		tl.setLikeUserId(userId);
 		
 		int tradeLike = tradeService.getTradeLike(tl);
 		
 		model.addAttribute("heart", tradeLike);
 		} else {
 			int tradeLike = 0;
 			model.addAttribute("heart", tradeLike);
 		}
 		
		// ????????? ??????
		ModelAndView view = new ModelAndView();
        Cookie[] cookies = request.getCookies();
        
        // ???????????? ?????? ????????? ??????
        Cookie viewCookie = null;
 
        // ????????? ?????? ?????? 
        if (cookies != null && cookies.length > 0) 
        {
            for (int i = 0; i < cookies.length; i++)
            {
                // Cookie??? name??? cookie + reviewNo??? ???????????? ????????? viewCookie??? ????????? 
                if (cookies[i].getName().equals("cookie"+ no))
                { 
                	 log.debug("?????? ????????? ????????? ??? ?????????.");
                    viewCookie = cookies[i];
                }
            }
        }
        if (trade != null) {
        	 log.debug("System - ?????? ?????? ?????????????????? ?????????");
        	 
 
            // ?????? viewCookie??? null??? ?????? ????????? ???????????? ????????? ?????? ????????? ?????????.
            if (viewCookie == null) {    
            	 log.debug("cookie ??????");
                // ?????? ??????(??????, ???)
                Cookie newCookie = new Cookie("cookie"+ no, "|" + no + "|");  
                newCookie.setMaxAge(60 * 60 * 24);
                // ?????? ??????
                response.addCookie(newCookie);
                // ????????? ?????? ????????? ????????? ????????????
                int result = tradeService.updateReadCount(no);
                log.debug("?????????????????? ?????? : " + trade.getReadCount());
                
                if(result>=0) {
                	 log.debug("????????? ??????");
                }else {
                	 log.debug("????????? ?????? ??????");
                }
            }
            // viewCookie??? null??? ???????????? ????????? ???????????? ????????? ?????? ????????? ???????????? ??????.
            else {
            	 log.debug("cookie ??????");
                
                // ?????? ??? ?????????.
                String value = viewCookie.getValue();
                log.debug("?????????????????? ?????? : " + trade.getReadCount());
                log.debug("cookie ??? : " + value);     
            }
            
            log.debug("result = {}", trade);
            view.setViewName("trade/tradeView");
            return view;
        } 
        else {
            // ?????? ????????? ??????
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
			// ?????????????????? ??????
			if(!upFile.isEmpty()) {
				String saveDirectory = application.getRealPath("/resources/upload/trade");
				String renamedFilename = CampingEzUtils.getRenamedFilename(upFile.getOriginalFilename());
				File destFile = new File(saveDirectory, renamedFilename);
				upFile.transferTo(destFile);
				
				// DB??? ??????
				TradePhoto photo = new TradePhoto(upFile.getOriginalFilename(), renamedFilename);
				trade.add(photo);
			}
			
			
		}
		log.debug("trade = {}", trade);

		log.debug("upFileList = {}", upFileList);

		
		int result = tradeService.insertTrade(trade);
		
		redirectAttr.addFlashAttribute("msg", "????????? ?????? ??????");
		
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
		log.debug("trade = {}", trade);
		String saveDirectory = application.getRealPath("/resources/upload/trade");
		int result = 0;
		// ?????? ?????? ??????
		if(delFiles != null) {
			for(int photoNo : delFiles) {
				// ????????? ????????? ?????? ??????
				TradePhoto photo = tradeService.selectOnePhoto(photoNo);
				File delFile = new File(saveDirectory, photo.getRenamedFilename());
				boolean deleted = delFile.delete();
				
				// DB??? photo row ??????
				result = tradeService.deletePhoto(photoNo);
			}
		}
		
		// ????????? ?????? ??????(?????? ??????, insert??? ???????????? ??????)
		for(MultipartFile upFile : upFileList) {
			if(!upFile.isEmpty()) {
				// ????????? ??????
				if(!upFile.isEmpty()) {
					String renamedFilename = CampingEzUtils.getRenamedFilename(upFile.getOriginalFilename());
					File destFile = new File(saveDirectory, renamedFilename);
					upFile.transferTo(destFile);
					
					// DB??? ??????
					TradePhoto photo = new TradePhoto(upFile.getOriginalFilename(), renamedFilename);
					photo.setTdNo(trade.getTradeNo()); // fk ??????
					trade.add(photo);
			}
		}
		
	}

	// ????????? ??????
	result = tradeService.updateTrade(trade);
	
	// ?????????
	redirectAttr.addFlashAttribute("msg", "?????? ??????");
	
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
		
		// ????????? ??????
		SecurityContext securityContext = SecurityContextHolder.getContext();
 		Authentication authentication = securityContext.getAuthentication();
 		Object principal = authentication.getPrincipal();
 		log.debug("prin = {}", principal);
 		
 		User user = (User) principal;
 		String userId = user.getUserId();
		
 		// ????????? ??????
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
	
	
	
	@ResponseBody
	@GetMapping("/align")
	public ModelAndView tradeAlign(@RequestParam(defaultValue = "1") int cPage, HttpServletRequest request
							, @RequestParam String categoryId) {
		
		log.debug("categoryId = {} ", categoryId);
		
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<Trade> list = new ArrayList<>();
//		// 1. content??????
		Map<String, Integer> param = new HashMap<>();
		int limit = 12;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		int totalContent = 0;
		
		Map<String, Object> map = new HashMap<>();
		if("all".equals(categoryId)) {
			list = tradeService.selectTradeList(param);	
			totalContent = tradeService.getTotalContent();
		} 
		else {
			list = tradeService.selectTradeListKind(param, categoryId);
			totalContent = tradeService.getTotalContentKind(categoryId);
			log.debug("totalContent = {} ", totalContent);
		}
		
		mav.addObject("list", list);
		log.debug("list = {} ", list);
				
		// 2. pagebar??????
		log.debug("totalContent = {}", totalContent);
		String url = request.getRequestURI(); //
		String pagebar = CampingEzUtils.getPagebar(cPage, limit, totalContent, url);
		mav.addObject("pagebar", pagebar);
		return mav;
	}
	
	@PostMapping("/tradeSuccess.do")
	public ResponseEntity<?> tradeSuccess(@RequestParam String no) {
		int result = tradeService.updateSuccess(no);
		
		return ResponseEntity.ok().body(result);
	}

	
	@PostMapping("/tradeSuccess")
	public String tradeSuccess(RedirectAttributes redirectAttr, @RequestParam String no) {

		
		redirectAttr.addFlashAttribute("msg", "?????? ??????");
		
		return "redirect:/trade/tradeView.do?no=" + no;
	}
	
	@GetMapping("/selectCurrentTrade")
	public ResponseEntity<?> selectCurrentTrade(){
		List<Trade> list = tradeService.selectCurrentTrade();
		log.debug("list = {}", list);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(list);
	}
	
	
}
