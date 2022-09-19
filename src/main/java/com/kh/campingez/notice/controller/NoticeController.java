package com.kh.campingez.notice.controller;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campingez.common.CampingEzUtils;
import com.kh.campingez.notice.model.dto.Notice;
import com.kh.campingez.notice.model.dto.NoticePhoto;
import com.kh.campingez.notice.model.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	ServletContext application;
	
	@GetMapping("/list")
	public void list(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		// 1. content영역
		Map<String, Integer> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		List<Notice> list = noticeService.noticeList(param);
		log.debug("list = {}", list);
		model.addAttribute("list", list);
		
		// 2. pagebar영역
		int totalContent = noticeService.getTotalContent();
		log.debug("totalContent = {}", totalContent);
		String url = request.getRequestURI();
		String pagebar = CampingEzUtils.getPagebar2(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
	}
	
	@GetMapping("/detail")
	public void detail(@RequestParam String noticeNo, Model model) {
		Notice notice = noticeService.selectByNoticeNo(noticeNo);
		model.addAttribute("notice", notice);
	}
	
	@GetMapping("/update")
	public void update(@RequestParam String noticeNo, Model model) {
		Notice notice = noticeService.selectByNoticeNo(noticeNo);
		model.addAttribute("notice", notice);
	}
	
	@PostMapping("/update")
	public String update(@ModelAttribute Notice notice, @RequestParam(name = "upFile") List<MultipartFile> upFileList, 
			@RequestParam(name = "delFile", required = false ) int[] delFiles,
			RedirectAttributes redirectAttr) throws IllegalStateException, IOException {
		// 경로지정
		String saveDirectory = application.getRealPath("/resources/upload/notice");

		// 파일 저장
		for (MultipartFile upFile : upFileList) {
			if (!upFile.isEmpty()) {
				// rename
				String renamedFilename = CampingEzUtils.getRenamedFilename(upFile.getOriginalFilename());

				File destFile = new File(saveDirectory, renamedFilename);
				// 해당 경로에 파일을 저장
				upFile.transferTo(destFile);

				NoticePhoto photo = new NoticePhoto(upFile.getOriginalFilename(), renamedFilename);
				photo.setNoticeNo(notice.getNoticeNo()); 
				notice.add(photo);
			}
		}
		// 파일 삭제
		if (delFiles != null) {
			for (int noticePhotoNo : delFiles) {
				NoticePhoto photo = noticeService.selectByPhotoNo(noticePhotoNo);
				File delFile = new File(saveDirectory, photo.getNoticeRenamedFilename());
				boolean deleted = delFile.delete();
				log.debug("{} 파일 삭제 : {}", photo.getNoticeRenamedFilename(), deleted);

				// db row 삭제
				int result = noticeService.deletePhoto(noticePhotoNo);
				log.debug("{} attachment recored 삭제", noticePhotoNo);
			}
		}
		
		int result = noticeService.updateNotice(notice);
		redirectAttr.addFlashAttribute("msg", "게시글을 수정하였습니다.");
		return "redirect:/notice/detail.do?noticeNo="+notice.getNoticeNo();
	}

	@GetMapping("/delete")
	public String delete(@RequestParam String noticeNo, RedirectAttributes redirectAttr) {
		int result = noticeService.deleteNotice(noticeNo);
		redirectAttr.addFlashAttribute("msg", "게시글을 삭제하였습니다.");
		return "redirect:/notice/list";
	}
	
	@GetMapping("/enrollEvent")
	public void enrollEvent() {}

	@GetMapping("/enrollNotice")
	public void enrollNotice() {}
	
	@PostMapping("/enrollNotice")
	public String enrollNotice(Notice notice, @RequestParam(name = "upFile") List<MultipartFile> upFileList, RedirectAttributes redirectAttr) 
			throws IllegalStateException, IOException {

		// 파일 저장
		for (MultipartFile upFile : upFileList) {
			if (!upFile.isEmpty()) {
				// 경로지정
				String saveDirectory = application.getRealPath("/resources/upload/notice");
				// rename
				String renamedFilename = CampingEzUtils.getRenamedFilename(upFile.getOriginalFilename());

				File destFile = new File(saveDirectory, renamedFilename);
				// 해당 경로에 파일을 저장
				upFile.transferTo(destFile);

				NoticePhoto photo = new NoticePhoto(upFile.getOriginalFilename(), renamedFilename);
				notice.add(photo);
			}
		}
		int result = noticeService.insertNotice(notice);
		redirectAttr.addFlashAttribute("msg", "게시글을 등록하였습니다.");
		return "redirect:/notice/list";
	}
	
}
